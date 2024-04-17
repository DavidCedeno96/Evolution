import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Categoria } from 'src/app/Models/Adicional';
import {
  AlertError,
  Loading,
  MsgError,
  MsgErrorForm,
  SetUpsert,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import {
  CaracterInvalid,
  exp_invalidos,
} from 'src/app/Utils/RegularExpressions';
import { CategoriaRecompensaService } from 'src/app/services/categoria-recompensa.service';

@Component({
  selector: 'app-upsert-categoria-recompensa',
  templateUrl: './upsert-categoria-recompensa.component.html',
  styleUrls: ['./upsert-categoria-recompensa.component.css'],
})
export class UpsertCategoriaRecompensaComponent
  implements OnInit, AfterViewInit
{
  alertError = AlertError();
  loading = Loading();
  setUpsert = SetUpsert();
  caracterInvalid = CaracterInvalid();

  type: string = '';
  titulo: string = '';

  verErrorsInputs: boolean = false;

  selectedImage!: File;
  previewImage: string = '';
  ErrorArchivo: boolean = false;
  id: string = '';
  campo: string = '';
  error: number = 0;
  info: string = '';

  formulario!: FormGroup;
  categoria: Categoria = {
    idCategoria: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: '',
    descripcion: '',
    estado: 0,
  };

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private categoriaServicio: CategoriaRecompensaService,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      idCategoria: [this.categoria.idCategoria],
      nombre: [
        this.categoria.nombre,
        [
          Validators.required,
          Validators.maxLength(50),
          Validators.pattern(exp_invalidos),
        ],
      ],
      descripcion: [
        this.categoria.descripcion,
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
      let idCategoria = params['categoria'];
      if (idCategoria === '' && this.type === 'editar') {
        history.back();
      }
      switch (this.type) {
        case 'crear': {
          this.titulo = 'nueva categoría';
          break;
        }
        case 'editar': {
          this.id = idCategoria;
          this.titulo = 'editar categoría';
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

  cargarData(idCategoria: string) {
    this.categoriaServicio.getItem(-1, idCategoria).subscribe({
      next: (data: any) => {
        let { error, categoriaNoticia } = data.response;
        if (error === 0) {
          this.categoria = categoriaNoticia;
          this.formulario.patchValue(categoriaNoticia);
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
    if (this.formulario.valid) {
      this.verErrorsInputs = false;
      this.categoria = this.formulario.value;
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
    this.categoriaServicio.create(this.categoria).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.setUpsert(true, 'Registro Creado');
          this.router.navigate(['/view-categoria-recompensa']);
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
    this.categoriaServicio.update(this.categoria).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.setUpsert(true, 'Registro Actualizado');
          this.router.navigate(['/view-categoria-recompensa']);
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
}
