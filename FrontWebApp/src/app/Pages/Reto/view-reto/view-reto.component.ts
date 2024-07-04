import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { ConfirmationService, MessageService } from 'primeng/api';
import { Reto } from 'src/app/Models/Reto';
import {
  AlertError,
  AlertWarning,
  ChangeRoute,
  DateCompare,
  FormatTiempo,
  GetImage,
  GetTypeTime,
  Loading,
  MsgActivado,
  MsgDesactivado,
  MsgEliminar,
  MsgElimindo,
  MsgOk,
  SetUpsert,
  SinRegistros,
  TitleEliminar,
  TitleError,
  TitleErrorForm,
  Upsert,
  UpsertMsg,
} from 'src/app/Utils/Constants';
import { RetoService } from 'src/app/services/reto.service';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-view-reto',
  templateUrl: './view-reto.component.html',
  styleUrls: ['./view-reto.component.css'],
  providers: [ConfirmationService, MessageService],
})
export class ViewRetoComponent implements OnInit, AfterViewInit {
  alertError = AlertError();
  alertWarning = AlertWarning();
  loading = Loading();
  setUpsert = SetUpsert();
  changeRoute = ChangeRoute();
  getImage = GetImage();
  dateCompare = DateCompare();
  formatTiempo = FormatTiempo();
  getTypeTime = GetTypeTime();

  info: string = '';

  formulario!: FormGroup;

  auxRetos: Reto[] = [];
  retos: Reto[] = [];
  reto: Reto = {
    idReto: '',
    nombre: '',
    fechaApertura: new Date(),
    fechaCierre: new Date(),
    vidas: 0,
    tiempo_ms: 0,
    puntosRecompensa: 0,
    creditosObtenidos: 0,
    instrucciones: '',
    criterioMinimo: 0,
    imagen: '',
    idTipoReto: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    tipoReto: '',
    idTipoEncuesta: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    tipoEncuesta: '',
    idComportamiento: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    comportamientoPregunta: '',
    idTipoArchivo: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    tipoArchivo: '',
    idTipoValidador: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    tipoValidador: '',
    totalPreguntas: 0,
    usuariosAsignados: 0,
    equiposAsignados: 0,
    validadores: 0,
    puedeValidar: 0,
    enEquipo: 0,
    opsRequeridas: 0,
    items: 0,
    estado: 0,
  };

  constructor(
    private confirmationService: ConfirmationService,
    private messageService: MessageService,
    private retoServicio: RetoService,
    private userService: UsuarioService,
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
          this.changeRoute('/404', {});
        }
      },
    });
  }

  submitBuscar() {
    let buscar = this.formulario.get(['buscar'])?.value;
    if (buscar.trim() !== '') {
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
          this.changeRoute('/404', {});
        }
      },
    });
  }

  clonar(reto: Reto) {
    console.log('Cloanando...', reto);
  }

  vistaPrevia(reto: Reto) {
    if (reto.estado === 1) {
      if (reto.tipoReto !== 'Comportamiento') {
        this.changeRoute('/juego-reto', { reto: reto.idReto });
        /* this.changeRoute('/validar-comportamiento', {
          reto: reto.idReto,
          user: this.userService.getIdUsuario(),
        }); */
      }
    } else {
      this.alertWarning(
        'Reto Desactivado',
        'Para ver el reto se requiere que actives el reto'
      );
    }
  }

  setEstado(reto: Reto, estado: number) {
    if (
      estado &&
      reto.totalPreguntas < 5 &&
      (reto.tipoReto === 'Trivia' ||
        reto.tipoReto === 'Encuesta' ||
        reto.tipoReto === 'Seguimiento o Evaluación' ||
        reto.tipoReto === 'Comportamiento')
    ) {
      this.alertError(
        TitleErrorForm,
        'No se puede activar el reto porque debe tener al menos 5 preguntas'
      );
    } else if (estado && !reto.usuariosAsignados && !reto.equiposAsignados) {
      this.alertError(
        TitleErrorForm,
        `No se puede activar el reto porque no se asignó ${
          reto.enEquipo ? 'equipos' : 'usuarios'
        }`
      );
    } else {
      this.loading(true, false);
      this.reto.idReto = reto.idReto;
      this.reto.estado = estado;

      this.retoServicio.updateEstado(this.reto).subscribe({
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
          this.changeRoute('/404', {});
        }
      },
    });
  }

  defaultList(event: Event) {
    let text = (event.target as HTMLInputElement).value;
    if (!text.trim()) {
      this.retos = this.auxRetos;
    }
  }
}
