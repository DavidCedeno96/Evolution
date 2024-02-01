import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { ConfirmationService, MessageService } from 'primeng/api';
import { Reto } from 'src/app/Models/Reto';
import {
  AlertError,
  ChangeRoute,
  DateFormat,
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
import { RetoService } from 'src/app/services/reto.service';

@Component({
  selector: 'app-view-reto',
  templateUrl: './view-reto.component.html',
  styleUrls: ['./view-reto.component.css'],
  providers: [ConfirmationService, MessageService],
})
export class ViewRetoComponent implements OnInit {
  alertError = AlertError();
  loading = Loading();
  changeRoute = ChangeRoute();
  getImage = GetImage();
  dateFormat = DateFormat();

  info: string = '';

  formulario!: FormGroup;
  auxRetos: Reto[] = [];

  retos: Reto[] = [
    {
      idReto: '',
      nombre: '',
      fechaApertura: new Date(),
      fechaCierre: new Date(),
      vidas: 0,
      tiempo_ms: 0,
      puntosRecompensa: 0,
      creditosObtenidos: 0,
      instrucciones: '',
      imagen: '',
      idTipoReto: '',
      tipoReto: '',
      idComportamiento: '',
      comportamiento: '',
      estado: 0,
    },
  ];

  constructor(
    private confirmationService: ConfirmationService,
    private messageService: MessageService,
    private retoServicio: RetoService,
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
    this.retoServicio.getList(-1).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.retos = lista;
          this.auxRetos = lista;
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
      this.retos = this.auxRetos;
    }
  }

  getBuscar(texto: string) {
    this.retoServicio.getBuscarList(texto).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.retos = lista;
        } else {
          this.retos = [];
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
    this.retoServicio.delete(idReto).subscribe({
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
      this.retos = this.auxRetos;
    }
  }
}
