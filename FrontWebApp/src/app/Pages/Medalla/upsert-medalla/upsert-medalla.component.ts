import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Condicion } from 'src/app/Models/Adicional';
import { Medalla } from 'src/app/Models/Medalla';
import {
  AlertError,
  GetImage,
  ImgSizeMax,
  Loading,
  MsgError,
  MsgErrorForm,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import {
  CaracterInvalid,
  exp_invalidos,
} from 'src/app/Utils/RegularExpressions';
import { AdicionalService } from 'src/app/services/adicional.service';
import { MedallaService } from 'src/app/services/medalla.service';

@Component({
  selector: 'app-upsert-medalla',
  templateUrl: './upsert-medalla.component.html',
  styleUrls: ['./upsert-medalla.component.css'],
})
export class UpsertMedallaComponent implements OnInit, AfterViewInit {
  getImage = GetImage();
  alertError = AlertError();
  loading = Loading();
  caracterInvalid = CaracterInvalid();

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

  medalla: Medalla = {
    idMedalla: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: '',
    descripcion: '',
    imagen: '',
    totalUsuarios: 0,
    idCondicion: '',
    condicion: '',
    estado: 0,
  };

  condicion: Condicion[] = [];

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private medallaServicio: MedallaService,
    private adicionalServicio: AdicionalService,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      idMedalla: [this.medalla.idMedalla],
      nombre: [
        this.medalla.nombre,
        [
          Validators.required,
          Validators.maxLength(30),
          Validators.pattern(exp_invalidos),
        ],
      ],
      descripcion: [
        this.medalla.descripcion,
        [Validators.maxLength(250), this.caracterInvalid],
      ],

      imagen: [this.medalla.imagen],

      idCondicion: [this.medalla.idCondicion, [Validators.required]],
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
      let idMedalla = params['medalla'];
      if (idMedalla === '' && this.type === 'editar') {
        history.back();
      }
      switch (this.type) {
        case 'crear': {
          this.titulo = 'nueva medalla';
          break;
        }
        case 'editar': {
          this.id = idMedalla;
          this.titulo = 'editar medalla';
          break;
        }
        default: {
          this.titulo = '';
          history.back();
          break;
        }
      }
    });
    this.cargarAdicionales();
  }

  cargarData(idMedalla: string) {
    this.medallaServicio.getItem(-1, idMedalla).subscribe({
      next: (data: any) => {
        let { error, medalla } = data.response;
        if (error === 0) {
          this.medalla = medalla;
          this.formulario.patchValue(medalla);
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

  cargarAdicionales() {
    this.adicionalServicio.getListMedalla(1).subscribe({
      next: (data: any) => {
        let { condicionList } = data.response;
        this.condicion = condicionList.lista;
      },
      error: (e) => {
        console.error(e);
        if (e.status === 401 || e.status === 403) {
          this.router.navigate(['/']);
        } else {
          this.alertError(TitleError, MsgError);
        }
      },
    });
  }

  upsert() {
    if (this.formulario.valid && !this.errorArchivo) {
      this.verErrorsInputs = false;
      this.medalla = this.formulario.value;
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
    this.medallaServicio.create(this.getFormData()).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.router.navigate(['/view-medalla']);
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
    this.medallaServicio.update(this.getFormData()).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.router.navigate(['/view-medalla']);
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
    formData.append('idMedalla', this.medalla.idMedalla);
    formData.append('nombre', this.medalla.nombre.trim());
    formData.append('descripcion', this.medalla.descripcion.trim());
    formData.append('idCondicion', this.medalla.idCondicion.trim());

    if (this.selectedImage) {
      formData.append('archivo', this.selectedImage);
    }

    return formData;
  }

  onFileSelected(event: Event) {
    this.selectedImage = (event.target as HTMLInputElement).files![0];

    if (this.selectedImage.size > ImgSizeMax) {
      this.errorArchivo = true;
    } else {
      this.errorArchivo = false;
    }

    if (this.selectedImage.size > 0) {
      let reader = new FileReader();
      reader.onload = (e: any) => {
        this.previewImage = e.target.result;
      };
      reader.readAsDataURL(this.selectedImage);
    }
    console.log(this.selectedImage.name, this.previewImage);
  }
}
