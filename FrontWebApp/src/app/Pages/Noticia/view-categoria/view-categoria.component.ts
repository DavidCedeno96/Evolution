import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { Categoria } from 'src/app/Models/Adicional';
import {
  AlertError,
  ChangeRoute,
  Loading,
  MsgError,
  SinRegistros,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { CategoriaNoticiaService } from 'src/app/services/categoria-noticia.service';

@Component({
  selector: 'app-view-categoria',
  templateUrl: './view-categoria.component.html',
  styleUrls: ['./view-categoria.component.css'],
})
export class ViewCategoriaComponent implements OnInit {
  alertError = AlertError();
  loading = Loading();
  changeRoute = ChangeRoute();

  info: string = '';

  formulario!: FormGroup;

  auxCategorias: Categoria[] = [];

  categorias: Categoria[] = [
    {
      idCategoria: '',
      nombre: '',
      descripcion: '',
      estado: 0,
    },
  ];

  constructor(
    /* private confirmationService: ConfirmationService,
    private messageService: MessageService, */
    private categoriaServicio: CategoriaNoticiaService,
    private router: Router,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      buscar: [''],
    });
  }

  ngOnInit(): void {
    this.loading(true, false);
    this.cargarData();
  }

  cargarData() {
    this.categoriaServicio.getList(-1).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.categorias = lista;
          this.auxCategorias = lista;
          this.info = SinRegistros;
        } else {
          this.alertError(TitleErrorForm, info);
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

  submitBuscar() {
    let buscar = this.formulario.get(['buscar'])?.value;
    if (buscar !== '') {
      this.loading(true, false);
      this.getBuscar(buscar);
    } else {
      this.categorias = this.auxCategorias;
    }
  }

  getBuscar(texto: string) {
    this.categoriaServicio.getBuscarList(texto).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.categorias = lista;
        } else {
          this.categorias = [];
          this.info = info;
        }
        this.loading(false, false);
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

  /* confirmEliminar(id: string) {
    this.categoriaServicio.confirm({
      message: MsgEliminar,
      header: TitleEliminar,
      accept: () => this.eliminar(id),
    });
  }

  eliminar(idReto: string) {
    this.loading(true, false);
    this.categoriaServicio.delete(idReto).subscribe({
      next: (data: any) => {
        let { error, info } = data.response;
        if (error === 0) {
          this.messageService.add({
            severity: 'success',
            summary: MsgOk,
            detail: MsgElimindo,
          });
          this.cargarData();
        } else {
          this.loading(false, false);
          this.alertError(TitleError, info);
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
  } */

  defaultList(event: Event) {
    let text = (event.target as HTMLInputElement).value;
    if (!text) {
      this.categorias = this.auxCategorias;
    }
  }
}
