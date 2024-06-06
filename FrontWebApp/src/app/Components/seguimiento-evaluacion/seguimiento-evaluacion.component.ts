import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { PreguntaOpciones } from 'src/app/Models/Pregunta';
import { Reto } from 'src/app/Models/Reto';
import {
  AlertError,
  ChangeRoute,
  DateCompare,
  Loading,
  MsgError,
  ReproducirSonido,
  SoundQuizVictory,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { exp_invalidos } from 'src/app/Utils/RegularExpressions';
import { PreguntaService } from 'src/app/services/pregunta.service';
import { RetoService } from 'src/app/services/reto.service';
import { TranslateService } from '@ngx-translate/core';
import { PrimeNGConfig } from 'primeng/api';

@Component({
  selector: 'app-seguimiento-evaluacion',
  templateUrl: './seguimiento-evaluacion.component.html',
  styleUrls: ['./seguimiento-evaluacion.component.css'],
})
export class SeguimientoEvaluacionComponent implements OnInit, AfterViewInit {
  load = Loading();
  dateCompare = DateCompare();
  alertError = AlertError();
  reproducirSonido = ReproducirSonido();
  changeRoute = ChangeRoute();

  first: number = 0;
  rows: number = 5; // items por página
  modal: boolean = false;

  verErrorsInputs: boolean = false;

  idReto: string = '';

  date: Date[] | undefined;

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
    idTipoEncuesta: '',
    tipoEncuesta: '',
    idComportamiento: '',
    comportamientoPregunta: '',
    idTipoArchivo: '',
    tipoArchivo: '',
    idTipoValidador: '',
    tipoValidador: '',
    totalPreguntas: 0,
    usuariosAsignados: 0,
    equiposAsignados: 0,
    validadores: 0,
    puedeValidar: 0,
    enEquipo: 0,
    estado: 0,
    opsRequeridas: 0,
    items: 0,
  };

  preguntaOpciones: PreguntaOpciones[] = [
    {
      pregunta: {
        idPregunta: '',
        idReto: '',
        nombre:
          '¿Cuáles son los tres predadores del reino animal reconocidos por: 1) habilidad de cazar en grupo, 2) camuflajearse para sorprender a su presa, 3) poseer sentidos refinados?',
      },
      opcionList: [
        {
          idOpcion: '',
          idPregunta: '',
          idTipoEntrada: '',
          tipoEntrada: '',
          nombre: '1) Tiburón blanco; 2) elefante; 3) escorpión',
          correcta: 0,
          cantVotos: 0,
          valor: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          idTipoEntrada: '',
          tipoEntrada: '',
          nombre: '1) Leon; 2) elefante; 3) escorpión',
          correcta: 0,
          cantVotos: 0,
          valor: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          idTipoEntrada: '',
          tipoEntrada: '',
          nombre: '1) Hiena; 2) Oso polar; 3) Lobo gris',
          correcta: 0,
          cantVotos: 0,
          valor: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          idTipoEntrada: '',
          tipoEntrada: '',
          nombre: '1) Tigre; 2) águila; 3) gato',
          correcta: 1,
          cantVotos: 0,
          valor: 0,
        },
      ],
    },
  ];

  formulario: FormGroup;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private preguntaServicio: PreguntaService,
    private retoService: RetoService, //private usuarioService: UsuarioService
    private translateService: TranslateService,
    private config: PrimeNGConfig,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({});

    this.translateService.setDefaultLang('es');
    this.translateService.use('es');
    this.translateService.get('primeng').subscribe((res) => {
      this.config.setTranslation(res);
    });
  }

  ngOnInit(): void {
    this.load(true, false);
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    this.cargarReto();
  }

  getRouteParams() {
    this.route.queryParams.subscribe((params) => {
      this.idReto = params['reto'];
      if (this.idReto === '' || !params['reto']) {
        history.back();
      }
    });
  }

  cargarReto() {
    this.retoService.getUsuario_RetoByIdUsuarioYIdReto(this.idReto).subscribe({
      next: (data: any) => {
        let { error, ur } = data.response;
        if (error === 0) {
          this.reto = ur.reto;

          let estado: number = 1;
          let fechaHoy = new Date();
          fechaHoy.setHours(0, 0, 0, 0);

          if (
            new Date(ur.reto.fechaApertura) >= fechaHoy &&
            this.dateCompare(ur.reto.fechaApertura) !== 'N/A'
          ) {
            estado = 0;
          }
          if (
            new Date(ur.reto.fechaCierre) < fechaHoy &&
            this.dateCompare(ur.reto.fechaCierre) !== 'N/A'
          ) {
            estado = 0;
          }

          if (
            estado === 0 ||
            ur.reto.totalPreguntas < 1 ||
            ur.reto.completado === 1
          ) {
            this.router.navigate(['/user-reto']);
          } else {
            this.cargarPreguntas();
          }
        } else {
          this.router.navigate(['/user-reto']);
          this.load(false, false);
        }
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

  cargarPreguntas() {
    this.preguntaServicio.getList(-1, this.idReto).subscribe({
      next: (data: any) => {
        let { error, info, list } = data.response;
        if (error === 0) {
          this.preguntaOpciones = list;

          this.preguntaOpciones.forEach((item) => {
            item.opcionList.forEach((op) => {
              this.agregarControlform(op.tipoEntrada, op.nombre, op.idOpcion);
            });
          });

          //this.usuarioService.clearWatching();
        } else {
          this.alertError(TitleErrorForm, info);
        }
        this.load(false, false);
      },
      error: (e) => {
        console.error(e);
        if (e.status === 401 || e.status === 403) {
          this.router.navigate(['/']);
        } else {
          this.alertError(TitleError, MsgError);
          this.load(false, false);
        }
      },
    });
  }

  finalizar() {
    /* console.log(this.formulario.valid);
    console.log(this.formulario.value); */

    this.load(true, false);

    if (this.formulario.valid || this.reto.opsRequeridas === 0) {
      this.verErrorsInputs = false;

      this.retoService
        .updateUsuario_retoSeg_evaluacion(this.setData())
        .subscribe({
          next: (data: any) => {
            let { error, info } = data.response;
            if (error === 0) {
              this.reproducirSonido(SoundQuizVictory);

              this.changeRoute('/fin-reto', { reto: this.idReto });
            } else {
              this.alertError(TitleErrorForm, info); //MsgErrorForm
            }
            this.load(false, false);
          },
          error: (e) => {
            console.error(e);
            if (e.status === 401 || e.status === 403) {
              this.router.navigate(['/']);
            } else {
              this.alertError(TitleError, MsgError);
              this.load(false, false);
            }
          },
        });
    } else {
      this.verErrorsInputs = true;
      this.modal = true;
      this.load(false, false);
    }
  }

  setPreguntasSinContestar(): string[] {
    let list: string[] = [];

    if (!this.formulario.valid) {
      for (let item in this.formulario.value) {
        if (
          this.formulario.value[item] === '' ||
          this.formulario.value[item] === null
        ) {
          let idOption = item.split('_|_')[3];
          let idPregunta: string = '';
          let preguntaName: string = '';

          this.preguntaOpciones.forEach((preOps) => {
            let option = preOps.opcionList.find(
              (op) => op.idOpcion === idOption
            );
            if (option) {
              idPregunta = option.idPregunta;
            }
          });

          this.preguntaOpciones.forEach((preOps) => {
            if (preOps.pregunta.idPregunta === idPregunta) {
              preguntaName = preOps.pregunta.nombre;
            }
          });

          let pregunta = `${this.getNumberPregunta(
            idPregunta
          )}. ${preguntaName}`;

          if (!list.includes(pregunta)) {
            list.push(pregunta);
          }
        }
      }
    }

    return list;
  }

  getNumberPregunta(idPregunta: string): number {
    let index: number = this.preguntaOpciones.findIndex(
      (item) => item.pregunta.idPregunta === idPregunta
    );
    return index + 1;
  }

  agregarControlform(type: string, name: string, id: string) {
    this.formulario.addControl(
      `op_|_${type}_|_${name}_|_${id}`,
      this.formBuilder.control('', [
        Validators.required,
        Validators.maxLength(350),
        Validators.pattern(exp_invalidos),
      ])
    );
  }

  setDefaultTime(control: string): void {
    let value: string = this.formulario.get([`${control}`])?.value;
    let defaultValue: Date = new Date();

    if (value === '' || value === null) {
      this.formulario.patchValue({
        [control]: defaultValue,
      });
    }
  }

  setData(): FormData {
    let formData = new FormData();

    const values = Object.values(this.formulario.value);
    const keys = Object.keys(this.formulario.value);

    const idsOptionsValues: string[] = [];

    keys.forEach((key, index) => {
      let value = values[index];
      let idOption = key.split('_|_')[3];
      let type = key.split('_|_')[1];

      if (value instanceof Date) {
        value = this.formatDateTime(value, type);
      }
      idsOptionsValues.push(String(idOption + '_|_' + value));
    });

    formData.append('idReto', this.idReto);
    formData.append('jsonList', JSON.stringify(idsOptionsValues));

    return formData;
  }

  formatDateTime(date: Date, type: string) {
    const day = String(date.getDate()).padStart(2, '0');
    const month = String(date.getMonth() + 1).padStart(2, '0'); // Los meses van de 0-11, por eso sumamos 1
    const year = date.getFullYear();
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');

    let fecha = `${day}/${month}/${year}`;
    let hora = `${hours}:${minutes}`;

    return type === 'Fecha' ? fecha : hora;
  }

  paginatedItems(): PreguntaOpciones[] {
    const startIndex = this.first;
    const endIndex = startIndex + this.rows;
    return this.preguntaOpciones.slice(startIndex, endIndex);
  }

  totalItems(): number {
    return this.preguntaOpciones.length;
  }

  onPageChange(event: any) {
    this.first = event.first;
    this.rows = event.rows;

    window.scrollTo({ top: 0, behavior: 'smooth' });
  }
}
