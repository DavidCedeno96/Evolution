import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ConfirmationService, MessageService } from 'primeng/api';
import { Pregunta, PreguntaOpciones } from 'src/app/Models/Pregunta';
import {
  AlertError,
  ChangeRoute,
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
import { PreguntaService } from 'src/app/services/pregunta.service';

@Component({
  selector: 'app-view-pregunta',
  templateUrl: './view-pregunta.component.html',
  styleUrls: ['./view-pregunta.component.css'],
  providers: [ConfirmationService, MessageService],
})
export class ViewPreguntaComponent implements OnInit, AfterViewInit {
  alertError = AlertError();
  loading = Loading();
  changeRoute = ChangeRoute();

  info: string = '';
  idReto: string = '';

  formulario!: FormGroup;
  auxPreguntaOpciones: PreguntaOpciones[] = [];

  preguntaOpciones: PreguntaOpciones[] = [
    {
      pregunta: {
        idPregunta: '',
        idReto: '',
        nombre: '',
      },
      opcionList: [
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '',
          correcta: 0,
        },
      ],
    },
  ];

  constructor(
    private route: ActivatedRoute,
    private confirmationService: ConfirmationService,
    private messageService: MessageService,
    private preguntaServicio: PreguntaService,
    private router: Router,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      buscar: [''],
    });
  }

  ngOnInit(): void {
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    this.loading(true, false);
    this.cargarData();
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
    this.preguntaServicio.getList(-1, this.idReto).subscribe({
      next: (data: any) => {
        let { error, info, list } = data.response;
        if (error === 0) {
          this.preguntaOpciones = list;
          this.auxPreguntaOpciones = list;
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
      this.preguntaOpciones = this.auxPreguntaOpciones;
    }
  }

  getBuscar(texto: string) {
    this.preguntaServicio.getBuscarList(texto, this.idReto).subscribe({
      next: (data: any) => {
        let { error, info, list } = data.response;
        if (error === 0) {
          this.preguntaOpciones = list;
        } else {
          this.preguntaOpciones = [];
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
    this.preguntaServicio.delete(idReto).subscribe({
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
      this.preguntaOpciones = this.auxPreguntaOpciones;
    }
  }
}
