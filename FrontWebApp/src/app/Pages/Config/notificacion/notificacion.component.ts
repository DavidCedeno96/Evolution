import { AfterViewInit, Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { Notificacion } from 'src/app/Models/Notificacion';
import {
  AlertError,
  ChangeRoute,
  Loading,
  MsgActivado,
  MsgDesactivado,
  MsgError,
  MsgOk,
  SetUpsert,
  SinRegistros,
  TitleError,
  TitleErrorForm,
  Upsert,
  UpsertMsg,
} from 'src/app/Utils/Constants';
import { NotificacionService } from 'src/app/services/notificacion.service';

@Component({
  selector: 'app-notificacion',
  templateUrl: './notificacion.component.html',
  styleUrls: ['./notificacion.component.css'],
  providers: [MessageService],
})
export class NotificacionComponent implements OnInit, AfterViewInit {
  changeRoute = ChangeRoute();
  loading = Loading();
  alertError = AlertError();
  setUpsert = SetUpsert();

  info: string = SinRegistros;

  notificacion: Notificacion = {
    idNotificacion: '',
    nombre: '',
    estado: 0,
    msgPersonalizado: '',
    descripcion: '',
    numDesc: 0,
    enviarCorreo: 0,
  };

  notificaciones: Notificacion[] = [];

  constructor(
    private messageService: MessageService,
    private notificacionServicio: NotificacionService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.loading(true, false);
    this.cargarData();
  }

  ngAfterViewInit(): void {
    if (Upsert) {
      setTimeout(() => {
        this.messageService.add({
          severity: 'success',
          summary: MsgOk,
          detail: UpsertMsg,
        });
        this.setUpsert(false, '');
      }, 100);
    }
  }

  cargarData() {
    this.notificacionServicio.getList(-1).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.notificaciones = lista;
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
          this.changeRoute('/404', {});
        }
      },
    });
  }

  setEstado(idNotificacion: string, currentEstado: number) {
    this.loading(true, false);
    let estado = currentEstado ? 0 : 1;
    this.notificacion.idNotificacion = idNotificacion;
    this.notificacion.estado = estado;

    this.notificacionServicio.updateEstado(this.notificacion).subscribe({
      next: (data: any) => {
        let { error, info } = data.response;
        if (error === 0) {
          this.cargarData();
          this.messageService.add({
            severity: 'success',
            summary: MsgOk,
            detail: estado ? MsgActivado : MsgDesactivado,
          });
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
          this.changeRoute('/404', {});
        }
      },
    });
  }
}
