import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { ConfirmationService, MessageService } from 'primeng/api';
import { Equipo } from 'src/app/Models/Equipo';
import {
  AlertError,
  ChangeRoute,
  GetImage,
  Loading,
  MsgActivado,
  MsgDesactivado,
  MsgEliminar,
  MsgElimindo,
  MsgError,
  MsgOk,
  SetUpsert,
  SinRegistros,
  TitleEliminar,
  TitleError,
  TitleErrorForm,
  Upsert,
  UpsertMsg,
} from 'src/app/Utils/Constants';
import { EquipoService } from 'src/app/services/equipo.service';

@Component({
  selector: 'app-view-equipo',
  templateUrl: './view-equipo.component.html',
  styleUrls: ['./view-equipo.component.css'],
  providers: [ConfirmationService, MessageService],
})
export class ViewEquipoComponent implements OnInit, AfterViewInit {
  alertError = AlertError();
  loading = Loading();
  setUpsert = SetUpsert();
  changeRoute = ChangeRoute();
  getImage = GetImage();

  info: string = '';

  formulario!: FormGroup;

  auxEquipos: Equipo[] = [];
  equipos: Equipo[] = [];
  equipo: Equipo = {
    idEquipo: '',
    nombre: '',
    imagen: '',
    descripcion: '',
    totalUsuarios: 0,
    estado: 0,
  };

  constructor(
    private confirmationService: ConfirmationService,
    private messageService: MessageService,
    private equipoServicio: EquipoService,
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
    this.equipoServicio.getList(-1).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.equipos = lista;
          this.auxEquipos = lista;
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
    if (buscar.trim() !== '') {
      this.loading(true, false);
      this.getBuscar(buscar);
    } else {
      this.equipos = this.auxEquipos;
    }
  }

  getBuscar(texto: string) {
    this.equipoServicio.getBuscarList(texto).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.equipos = lista;
        } else {
          this.equipos = [];
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

  setEstado(equipo: Equipo, estado: number) {
    if (estado && !equipo.totalUsuarios) {
      this.alertError(
        TitleErrorForm,
        'No se puede activar el equipo porque no se asignó ningún usuario'
      );
    } else {
      this.loading(true, false);

      this.equipo = equipo;
      this.equipo.estado = estado;

      this.equipoServicio.updateEstado(this.equipo).subscribe({
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
            this.alertError(TitleError, MsgError);
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

  eliminar(idEquipo: string) {
    this.loading(true, false);
    this.equipoServicio.delete(idEquipo).subscribe({
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
    if (!text.trim()) {
      this.equipos = this.auxEquipos;
    }
  }
}
