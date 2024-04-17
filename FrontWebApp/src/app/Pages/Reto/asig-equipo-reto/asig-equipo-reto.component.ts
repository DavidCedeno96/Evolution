import {
  AfterViewInit,
  Component,
  ElementRef,
  OnInit,
  ViewChild,
} from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ConfirmationService, MessageService } from 'primeng/api';
import { Equipo } from 'src/app/Models/Equipo';
import { Equipo_Reto } from 'src/app/Models/Reto';
import { Response } from 'src/app/Models/Response';
import {
  AlertError,
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
import { EquipoService } from 'src/app/services/equipo.service';
import { RetoService } from 'src/app/services/reto.service';

@Component({
  selector: 'app-asig-equipo-reto',
  templateUrl: './asig-equipo-reto.component.html',
  styleUrls: ['./asig-equipo-reto.component.css'],
  providers: [ConfirmationService, MessageService],
})
export class AsigEquipoRetoComponent implements OnInit, AfterViewInit {
  loading = Loading();
  alertError = AlertError();
  getImage = GetImage();
  sinRegistros = SinRegistros;

  @ViewChild('closeModalAsignar') closeModalAsignar!: ElementRef;

  idReto: string = '';
  info: string = '';
  error: number = 0;
  responseList: Response[] = [];

  equiposIds: string[] = [];
  equipos: Equipo[] = [];
  equipoReto: Equipo_Reto[] = [];
  modal: boolean = false;

  constructor(
    private confirmationService: ConfirmationService,
    private messageService: MessageService,
    private route: ActivatedRoute,
    private router: Router,
    private retoServicio: RetoService,
    private equipoServicio: EquipoService
  ) {}

  ngOnInit(): void {
    this.loading(true, false);
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    this.cargarData();
    this.cargarEquipos();
  }

  getRouteParams() {
    this.route.queryParams.subscribe((params) => {
      this.idReto = params['reto'];
      if (this.idReto === '' || !params['reto']) {
        history.back();
      }
    });
  }

  cargarData() {
    this.retoServicio.getEquipoByReto(this.idReto, -1).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.equipoReto = lista;
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
          history.back();
        }
      },
    });
  }

  cargarEquipos() {
    this.equipoServicio.getList(1).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.equipos = lista;
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

  submitEquipo() {
    if (this.equiposIds.length) {
      this.retoServicio
        .createEquipo_Reto(this.idReto, this.getFormData())
        .subscribe({
          next: (data: any) => {
            this.responseList = data.response;
            if (this.responseList.length) {
              this.cargarData();
              this.limpiarCampos();
              this.modal = true;
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
    } else {
      this.alertError(TitleErrorForm, 'lista de equipos vacios');
    }
  }

  confirmEliminar(idReto: string, idEquipo: string) {
    this.confirmationService.confirm({
      message: MsgEliminar,
      header: TitleEliminar,
      accept: () => this.eliminarEquipoReto(idReto, idEquipo),
    });
  }

  eliminarEquipoReto(idReto: string, idEquipo: string) {
    this.loading(true, false);
    this.retoServicio.deleteEquipoReto(idReto, idEquipo).subscribe({
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

  getFormData(): FormData {
    let formData = new FormData();
    formData.append('jsonList', JSON.stringify(this.equiposIds));

    return formData;
  }

  selectEquipo(idEquipo: string) {
    let index = this.equiposIds.indexOf(idEquipo);
    if (index !== -1) {
      this.equiposIds.splice(index, 1);
    } else {
      this.equiposIds.push(idEquipo);
    }
  }

  limpiarCampos() {
    this.closeModalAsignar.nativeElement.click();
  }
}
