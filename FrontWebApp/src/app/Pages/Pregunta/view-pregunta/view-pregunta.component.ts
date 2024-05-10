import {
  AfterViewInit,
  Component,
  ElementRef,
  OnInit,
  ViewChild,
} from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ConfirmationService, MessageService } from 'primeng/api';
import { PreguntaOpciones } from 'src/app/Models/Pregunta';
import { Reto } from 'src/app/Models/Reto';
import {
  AlertError,
  ChangeRoute,
  Loading,
  MsgEliminar,
  MsgElimindo,
  MsgError,
  MsgErrorArchivo,
  MsgFormatoDescargado,
  MsgOk,
  SetUpsert,
  SinRegistros,
  TitleEliminar,
  TitleError,
  TitleErrorArchivo,
  TitleErrorForm,
  Upsert,
  UpsertMsg,
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
  setUpsert = SetUpsert();
  changeRoute = ChangeRoute();

  @ViewChild('closeModal') closeModal!: ElementRef;
  @ViewChild('valueArchivo') valueArchivo!: ElementRef;

  selectedFile: File | null = null;
  errorArchivo: boolean = false;

  maxOptions: string = 'cinco';
  exportNameArchive: string = '';

  info: string = '';
  idReto: string = '';

  formulario!: FormGroup;

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
    idTipoReto: '',
    tipoReto: '',
    idTipoEncuesta: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    tipoEncuesta: '',
    idComportamiento: '',
    comportamientoPregunta: '',
    estado: 0,
    totalPreguntas: 0,
    usuariosAsignados: 0,
    equiposAsignados: 0,
    enEquipo: 0,
    opsRequeridas: 0,
  };

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
          cantVotos: 0,
          valor: 0,
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
        let { error, info, list, reto } = data.response;
        if (error === 0) {
          this.preguntaOpciones = list;
          this.auxPreguntaOpciones = list;
          this.reto = reto;
          this.info = SinRegistros;

          switch (this.reto.tipoReto) {
            case 'Trivia': {
              this.maxOptions = 'cuatro';
              this.exportNameArchive = 'FormatoPreguntasRetoTrivia.xlsx';
              break;
            }
            case 'Encuesta': {
              if (this.reto.tipoEncuesta === 'Voto') {
                this.exportNameArchive =
                  'FormatoPreguntasRetoEncuestaVoto.xlsx';
              } else if (this.reto.tipoEncuesta === 'Satisfacción') {
                this.exportNameArchive =
                  'FormatoPreguntasRetoEncuestaSatisfaccion.xlsx';
              }
            }
          }
        } else {
          this.alertError(TitleErrorForm, info);
        }
        this.loading(false, false);
      },
      error: (e) => {
        console.error(e, e.status);
        if (e.status === 401 || e.status === 403) {
          this.router.navigate(['/']);
        } else {
          history.back();
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
          this.loading(false, false);
          this.alertError(TitleError, MsgError);
        }
      },
    });
  }

  importArchivo() {
    if (this.selectedFile) {
      this.loading(true, false);
      this.errorArchivo = false;

      const formData = new FormData();
      formData.append('archivo', this.selectedFile);

      this.preguntaServicio.enviarArchivo(formData, this.idReto).subscribe({
        next: (data: any) => {
          const { info, error } = data.response;
          this.info = info;
          if (error === 0) {
            this.errorArchivo = false;
            this.limpiarArchivo();
            this.cargarData();
            this.messageService.add({
              severity: 'success',
              summary: MsgOk,
              detail: 'Preguntas creadas',
            });
          } else {
            this.errorArchivo = true;
          }
          this.loading(false, false);
        },
        error: (e) => {
          this.limpiarArchivo();
          console.error(e);
          if (e.status === 401 || e.status === 403) {
            this.router.navigate(['/']);
          } else {
            this.loading(false, false);
            this.alertError(TitleErrorArchivo, MsgErrorArchivo);
          }
        },
      });
    } else {
      this.errorArchivo = true;
      this.info = 'Ingrese un archivo en formato .xlsx';
    }
  }

  exportArchivo() {
    this.loading(true, false);
    this.preguntaServicio.getArchivo(this.exportNameArchive).subscribe({
      next: (data: Blob) => {
        const urlObject = window.URL.createObjectURL(data);
        const element = document.createElement('a');
        element.download = `Formato de Preguntas del Reto.xlsx`;
        element.href = urlObject;
        element.click();
        this.loading(false, false);
        this.messageService.add({
          severity: 'success',
          summary: MsgOk,
          detail: MsgFormatoDescargado,
        });
      },
      error: (e) => {
        console.error(e);
      },
    });
  }

  onFileSelected(event: Event) {
    this.selectedFile = (event.target as HTMLInputElement).files![0];
    this.errorArchivo = false;
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
          this.loading(false, false);
          this.alertError(TitleError, MsgError);
        }
      },
    });
  }

  defaultList(event: Event) {
    let text = (event.target as HTMLInputElement).value;
    if (!text.trim()) {
      this.preguntaOpciones = this.auxPreguntaOpciones;
    }
  }

  getUpsertRoute() {
    switch (this.reto.tipoReto) {
      case 'Trivia': {
        this.changeRoute('/upsert-pregunta/trivia', {
          type: 'crear',
          reto: this.idReto,
        });
        break;
      }
      case 'Encuesta': {
        if (this.reto.tipoEncuesta === 'Voto') {
          this.changeRoute('/upsert-pregunta/encuesta/voto', {
            type: 'crear',
            reto: this.idReto,
          });
        } else if (this.reto.tipoEncuesta === 'Satisfacción') {
          this.changeRoute('/upsert-pregunta/encuesta/satisfaccion', {
            type: 'crear',
            reto: this.idReto,
          });
        } else {
          this.changeRoute('/view-reto', {});
        }
        break;
      }
      default: {
        this.changeRoute('/view-reto', {});
      }
    }
  }

  limpiarArchivo() {
    this.closeModal.nativeElement.click();
    this.selectedFile = null;
    this.valueArchivo.nativeElement.value = '';
  }
}
