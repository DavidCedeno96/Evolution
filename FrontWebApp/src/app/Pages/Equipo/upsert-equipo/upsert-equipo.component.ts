import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Equipo } from 'src/app/Models/Equipo';
import {
  AlertError,
  GetImage,
  ImgHeightMax,
  ImgSizeMax,
  ImgWidthMax,
  Loading,
  MsgError,
  MsgErrorForm,
  SetUpsert,
  SugerenciaImagen,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import {
  CaracterInvalid,
  exp_invalidos,
} from 'src/app/Utils/RegularExpressions';
import { EquipoService } from 'src/app/services/equipo.service';

@Component({
  selector: 'app-upsert-equipo',
  templateUrl: './upsert-equipo.component.html',
  styleUrls: ['./upsert-equipo.component.css'],
})
export class UpsertEquipoComponent implements OnInit, AfterViewInit {
  getImage = GetImage();
  alertError = AlertError();
  loading = Loading();
  setUpsert = SetUpsert();
  caracterInvalid = CaracterInvalid();
  sugerenciaImagen = SugerenciaImagen;

  type: string = '';
  titulo: string = '';

  verErrorsInputs: boolean = false;

  selectedImage!: File;
  previewImage: string = '';
  errorArchivo: boolean = false;
  id: string = '';
  campo: string = '';
  error: number = 0;
  info: string = '';

  formulario!: FormGroup;
  equipo: Equipo = {
    idEquipo: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: '',
    imagen: '',
    descripcion: '',
    totalUsuarios: 0,
    estado: 0,
  };

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private equipoServicio: EquipoService,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      idEquipo: [this.equipo.idEquipo],
      nombre: [
        this.equipo.nombre,
        [
          Validators.required,
          Validators.maxLength(60),
          Validators.pattern(exp_invalidos),
        ],
      ],
      imagen: [this.equipo.imagen],

      descripcion: [
        this.equipo.descripcion,
        [Validators.maxLength(250), this.caracterInvalid],
      ],
    });
  }

  ngOnInit(): void {
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    if (this.type === 'editar') {
      this.loading(true, false);
      this.cargarData(this.id);
    }
  }

  getRouteParams() {
    this.route.queryParams.subscribe((params) => {
      this.type = params['type'];
      let idEquipo = params['equipo'];
      if (idEquipo === '' && this.type === 'editar') {
        history.back();
      }
      switch (this.type) {
        case 'crear': {
          this.titulo = 'nuevo equipo';
          break;
        }
        case 'editar': {
          this.id = idEquipo;
          this.titulo = 'editar equipo';
          break;
        }
        default: {
          this.titulo = '';
          history.back();
          break;
        }
      }
    });
  }

  cargarData(idEquipo: string) {
    this.equipoServicio.getItem(-1, idEquipo).subscribe({
      next: (data: any) => {
        let { error, equipo } = data.response;
        if (error === 0) {
          this.equipo = equipo;
          this.formulario.patchValue(equipo);
        } else {
          history.back();
        }
        this.loading(false, false);
      },
      error: (e) => {
        console.error(e);
        if (e.status === 401 || e.status === 403) {
          this.router.navigate(['/']);
        } else {
          history.back();
        }
      },
    });
  }

  upsert() {
    if (this.formulario.valid && !this.errorArchivo) {
      this.verErrorsInputs = false;
      this.equipo = this.formulario.value;
      //console.log('GUARDANDO ......');

      this.loading(true, false);
      switch (this.type) {
        case 'crear': {
          this.create();
          break;
        }
        case 'editar': {
          this.update();
          break;
        }
        default: {
          this.loading(false, false);
          history.back();
          break;
        }
      }
    } else {
      this.verErrorsInputs = true;

      this.alertError(TitleErrorForm, MsgErrorForm);
    }
  }

  create() {
    this.equipoServicio.create(this.getFormData()).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.setUpsert(true, 'Registro Creado');
          this.router.navigate(['/view-equipo']);
        } else if (campo !== '') {
          this.error = error;
          this.campo = campo;
          this.info = info;
          this.alertError(TitleErrorForm, info); //MsgErrorForm
        }
        this.loading(false, false);
      },
      error: (e) => {
        console.error(e);
        if (e.status === 401 || e.status === 403) {
          this.router.navigate(['/']);
        } else {
          this.alertError(TitleError, MsgError);
          this.loading(false, false);
        }
      },
    });
  }

  update() {
    this.equipoServicio.update(this.getFormData()).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.setUpsert(true, 'Registro Actualizado');
          this.router.navigate(['/view-equipo']);
        } else if (campo !== '') {
          this.error = error;
          this.campo = campo;
          this.info = info;
          this.alertError(TitleErrorForm, info); //MsgErrorForm
        }
        this.loading(false, false);
      },
      error: (e) => {
        console.error(e);
        if (e.status === 401 || e.status === 403) {
          this.router.navigate(['/']);
        } else {
          this.alertError(TitleError, MsgError);
          this.loading(false, false);
        }
      },
    });
  }

  getFormData(): FormData {
    let formData = new FormData();
    formData.append('idEquipo', this.equipo.idEquipo);
    formData.append('nombre', this.equipo.nombre.trim());
    formData.append('descripcion', this.equipo.descripcion.trim());

    if (this.selectedImage) {
      formData.append('archivo', this.selectedImage);
    }

    return formData;
  }

  onFileSelected(event: Event) {
    this.selectedImage = (event.target as HTMLInputElement).files![0];

    if (this.selectedImage) {
      let reader = new FileReader();
      reader.onload = (e: any) => {
        let img = new Image();
        img.src = e.target.result;
        img.onload = () => {
          let w = (img as HTMLImageElement).width;
          let h = (img as HTMLImageElement).height;

          if (
            this.selectedImage.size > ImgSizeMax ||
            w > ImgWidthMax ||
            h > ImgHeightMax
          ) {
            this.errorArchivo = true;
          } else {
            this.errorArchivo = false;
          }
        };

        this.previewImage = img.src;
      };
      reader.readAsDataURL(this.selectedImage);

      //console.log(this.selectedImage.name);
    }
  }
}
