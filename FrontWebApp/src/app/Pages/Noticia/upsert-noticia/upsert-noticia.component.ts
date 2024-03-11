import { AfterViewInit, Component, OnInit } from '@angular/core';
import {
  AbstractControl,
  FormBuilder,
  FormGroup,
  Validators,
} from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Categoria } from 'src/app/Models/Adicional';
import { Noticia } from 'src/app/Models/Noticia';
import {
  AlertError,
  DateFormatInput,
  GetImage,
  ImgSizeMax,
  Loading,
  MsgError,
  MsgErrorForm,
  SugerenciaImagen,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import {
  CaracterInvalid,
  exp_invalidos,
} from 'src/app/Utils/RegularExpressions';
import { AdicionalService } from 'src/app/services/adicional.service';
import { NoticiaService } from 'src/app/services/noticia.service';

@Component({
  selector: 'app-upsert-noticia',
  templateUrl: './upsert-noticia.component.html',
  styleUrls: ['./upsert-noticia.component.css'],
})
export class UpsertNoticiaComponent implements OnInit, AfterViewInit {
  getImage = GetImage();
  alertError = AlertError();
  loading = Loading();
  dateFormatInput = DateFormatInput();
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

  noticia: Noticia = {
    idNoticia: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    titular: '',
    descripcion: '',
    url: '',
    imagen: '',
    idCategoria: '',
    categoria: '',
    fechaPublicacion: new Date(),
    totalLikes: 0,
    totalComents: 0,
  };

  categorias: Categoria[] = [];

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private noticiaServicio: NoticiaService,
    private adicionalServicio: AdicionalService,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      idNoticia: [this.noticia.idNoticia],
      titular: [
        this.noticia.titular,
        [
          Validators.required,
          Validators.maxLength(100),
          Validators.pattern(exp_invalidos),
        ],
      ],
      descripcion: [
        this.noticia.descripcion,
        [
          Validators.required,
          Validators.maxLength(500),
          Validators.pattern(exp_invalidos),
        ],
      ],
      url: [
        this.noticia.url,
        [Validators.maxLength(250), this.caracterInvalid],
      ],

      imagen: [this.noticia.imagen],
      fechaPublicacion: [this.noticia.fechaPublicacion],

      idCategoria: [this.noticia.idCategoria, [Validators.required]],
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
      let idNoticia = params['noticia'];
      if (idNoticia === '' && this.type === 'editar') {
        history.back();
      }
      switch (this.type) {
        case 'crear': {
          this.titulo = 'nueva noticia';
          break;
        }
        case 'editar': {
          this.id = idNoticia;
          this.titulo = 'editar noticia';
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

  cargarData(idNoticia: string) {
    this.noticiaServicio.getItem(-1, idNoticia).subscribe({
      next: (data: any) => {
        let { error, noticia } = data.response;
        if (error === 0) {
          this.noticia = noticia;
          this.formulario.patchValue(noticia);
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
    this.adicionalServicio.getListNoticia(1).subscribe({
      next: (data: any) => {
        let { categoriaNoticiaList } = data.response;
        this.categorias = categoriaNoticiaList.lista;

        if (this.type === 'crear') {
          var categoria = this.categorias.filter((obj) => {
            return obj.nombre === 'General';
          });

          this.formulario.patchValue({
            idCategoria: categoria[0].idCategoria,
          });
        }
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
      this.noticia = this.formulario.value;
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
    this.noticiaServicio.create(this.getFormData()).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.router.navigate(['/view-noticia']);
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
    this.noticiaServicio.update(this.getFormData()).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.router.navigate(['/view-noticia']);
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
    formData.append('idNoticia', this.noticia.idNoticia);
    formData.append('titular', this.noticia.titular.trim());
    formData.append('descripcion', this.noticia.descripcion.trim());
    formData.append('url', this.noticia.url);
    formData.append('idCategoria', this.noticia.idCategoria.trim());
    formData.append(
      'fechaPublicacion',
      this.dateFormatInput(this.noticia.fechaPublicacion.toString())
    );

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

  objectType(control: AbstractControl): { [key: string]: boolean } | null {
    const value = control.value;

    if (value instanceof Date) {
      return { objectType: true };
    }

    return null;
  }
}
