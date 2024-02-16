import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Nivel } from 'src/app/Models/Nivel';
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
  exp_numeros,
} from 'src/app/Utils/RegularExpressions';
import { NivelService } from 'src/app/services/nivel.service';

@Component({
  selector: 'app-upsert-nivel',
  templateUrl: './upsert-nivel.component.html',
  styleUrls: ['./upsert-nivel.component.css'],
})
export class UpsertNivelComponent implements OnInit, AfterViewInit {
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
  nivel: Nivel = {
    idNivel: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: '',
    descripcion: '',
    puntosNecesarios: 0,
    imagen: '',
    totalUsuarios: 0,
    estado: 0,
    fechaCreacion: new Date(),
  };

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private nivelServicio: NivelService,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      idNivel: [this.nivel.idNivel],
      nombre: [
        this.nivel.nombre,
        [
          Validators.required,
          Validators.maxLength(20),
          Validators.pattern(exp_invalidos),
        ],
      ],
      descripcion: [
        this.nivel.descripcion,
        [Validators.maxLength(250), this.caracterInvalid],
      ],
      puntosNecesarios: [
        this.nivel.puntosNecesarios,
        [
          Validators.required,
          Validators.min(1),
          Validators.max(99999),
          Validators.pattern(exp_numeros),
        ],
      ],

      imagen: [this.nivel.imagen],
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
      let idNivel = params['nivel'];
      if (idNivel === '' && this.type === 'editar') {
        history.back();
      }
      switch (this.type) {
        case 'crear': {
          this.titulo = 'nuevo nivel';
          break;
        }
        case 'editar': {
          this.id = idNivel;
          this.titulo = 'editar nivel';
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

  cargarData(idNivel: string) {
    this.nivelServicio.getItem(-1, idNivel).subscribe({
      next: (data: any) => {
        let { error, nivel } = data.response;
        if (error === 0) {
          this.nivel = nivel;
          this.formulario.patchValue(nivel);
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
      this.nivel = this.formulario.value;
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
    this.nivelServicio.create(this.getFormData()).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.router.navigate(['/view-nivel']);
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
    this.nivelServicio.update(this.getFormData()).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.router.navigate(['/view-nivel']);
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
    formData.append('idNivel', this.nivel.idNivel);
    formData.append('nombre', this.nivel.nombre.trim());
    formData.append('descripcion', this.nivel.descripcion.trim());
    formData.append('puntosNecesarios', this.nivel.puntosNecesarios.toString());

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
