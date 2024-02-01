import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { ConfirmationService, MessageService } from 'primeng/api';
import { Recompensa } from 'src/app/Models/Recompensa';
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
import { RecompensaService } from 'src/app/services/recompensa.service';

@Component({
  selector: 'app-view-recompensa',
  templateUrl: './view-recompensa.component.html',
  styleUrls: ['./view-recompensa.component.css'],
  providers: [ConfirmationService, MessageService],
})
export class ViewRecompensaComponent implements OnInit {
  alertError = AlertError();
  loading = Loading();
  changeRoute = ChangeRoute();
  getImage = GetImage();

  info: string = '';

  formulario!: FormGroup;
  auxRecompensas: Recompensa[] = [];

  recompensas: Recompensa[] = [
    {
      idRecompensa: '',
      nombre: '',
      descripcion: '',
      imagen: '',
      cantDisponible: 0,
      cantCanje: 0,
      totalUsuarios: 0,
    },
  ];

  constructor(
    private confirmationService: ConfirmationService,
    private messageService: MessageService,
    private recompensaServicio: RecompensaService,
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
    this.recompensaServicio.getList(-1).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.recompensas = lista;
          this.auxRecompensas = lista;
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
      this.recompensas = this.auxRecompensas;
    }
  }

  getBuscar(texto: string) {
    this.recompensaServicio.getBuscarList(texto).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.recompensas = lista;
        } else {
          this.recompensas = [];
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
    this.recompensaServicio.delete(idReto).subscribe({
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
      this.recompensas = this.auxRecompensas;
    }
  }
}
