import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { ConfirmationService, MessageService } from 'primeng/api';
import { Nivel } from 'src/app/Models/Nivel';
import {
  AlertError,
  ChangeRoute,
  GetImage,
  Loading,
  MsgEliminar,
  MsgElimindo,
  MsgError,
  MsgOk,
  SinRegistros,
  TitleEliminar,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { NivelService } from 'src/app/services/nivel.service';

@Component({
  selector: 'app-view-nivel',
  templateUrl: './view-nivel.component.html',
  styleUrls: ['./view-nivel.component.css'],
  providers: [ConfirmationService, MessageService],
})
export class ViewNivelComponent implements OnInit {
  alertError = AlertError();
  loading = Loading();
  changeRoute = ChangeRoute();
  getImage = GetImage();

  info: string = '';

  formulario!: FormGroup;
  auxNivel: Nivel[] = [];

  nivel: Nivel[] = [
    {
      idNivel: '',
      nombre: '',
      descripcion: '',
      puntosNecesarios: 0,
      imagen: '',
      totalUsuarios: 0,
      estado: 0,
    },
  ];

  constructor(
    private confirmationService: ConfirmationService,
    private messageService: MessageService,
    private nivelServicio: NivelService,
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
    this.nivelServicio.getList(-1).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.nivel = lista;
          this.auxNivel = lista;
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
      this.nivel = this.auxNivel;
    }
  }

  getBuscar(texto: string) {
    this.nivelServicio.getBuscarList(texto).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.nivel = lista;
        } else {
          this.nivel = [];
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

  confirmEliminar(id: string) {
    this.confirmationService.confirm({
      message: MsgEliminar,
      header: TitleEliminar,
      accept: () => this.eliminar(id),
    });
  }

  eliminar(idReto: string) {
    this.loading(true, false);
    this.nivelServicio.delete(idReto).subscribe({
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
  }

  defaultList(event: Event) {
    let text = (event.target as HTMLInputElement).value;
    if (!text) {
      this.nivel = this.auxNivel;
    }
  }
}
