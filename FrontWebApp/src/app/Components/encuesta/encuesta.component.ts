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

@Component({
  selector: 'app-encuesta',
  templateUrl: './encuesta.component.html',
  styleUrls: ['./encuesta.component.css'],
})
export class EncuestaComponent implements OnInit, AfterViewInit {
  load = Loading();
  dateCompare = DateCompare();
  alertError = AlertError();
  reproducirSonido = ReproducirSonido();
  changeRoute = ChangeRoute();

  idReto: string = '';

  first: number = 0;
  rows: number = 5; // items por página

  modal: boolean = false;
  verErrorsInputs: boolean = false;
  formulario: FormGroup;

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
    enEquipo: 0,
    validadores: 0,
    puedeValidar: 0,
    estado: 0,
    opsRequeridas: 0,
    items: 0,
  };

  randomPreguntaOpciones: PreguntaOpciones[] = [];
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
          cantVotosXvalor: 0,
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
          cantVotosXvalor: 0,
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
          cantVotosXvalor: 0,
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
          cantVotosXvalor: 0,
        },
      ],
    },
  ];

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private preguntaServicio: PreguntaService,
    private retoService: RetoService, //private usuarioService: UsuarioService
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({});
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
        this.changeRoute('/404', {});
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
          this.changeRoute('/404', {});
        }
      },
    });
  }

  cargarPreguntas() {
    this.preguntaServicio.getList(-1, this.idReto).subscribe({
      next: (data: any) => {
        let { error, info, list } = data.response;
        if (error === 0) {
          if (this.reto.comportamientoPregunta === 'Aleatorio') {
            this.randomPreguntaOpciones = list;
            this.reordenarListaRandom();
            this.preguntaOpciones = this.randomPreguntaOpciones;
          } else {
            this.preguntaOpciones = list;
          }

          this.preguntaOpciones.forEach((item) => {
            this.agregarControlform(
              item.pregunta.nombre,
              item.pregunta.idPregunta
            );
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
          this.changeRoute('/404', {});
        }
      },
    });
  }

  finalizarEncuesta() {
    this.load(true, false);

    if (this.formulario.valid || this.reto.opsRequeridas === 0) {
      this.verErrorsInputs = false;

      this.retoService.updateUsuario_retoEncuesta(this.setData()).subscribe({
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
            this.changeRoute('/404', {});
          }
        },
      });
    } else {
      this.verErrorsInputs = true;
      this.modal = true;
      this.load(false, false);
    }
  }

  setData(): FormData {
    let formData = new FormData();

    const idsOpciones = Object.values(this.formulario.value);
    const selectedIdsOptions: string[] = idsOpciones.map((item) =>
      String(item)
    );

    formData.append('idReto', this.idReto);
    formData.append('jsonList', JSON.stringify(selectedIdsOptions));

    return formData;
  }

  reordenarListaRandom(): void {
    for (let i = this.randomPreguntaOpciones.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [this.randomPreguntaOpciones[i], this.randomPreguntaOpciones[j]] = [
        this.randomPreguntaOpciones[j],
        this.randomPreguntaOpciones[i],
      ];
    }
  }

  agregarControlform(name: string, id: string) {
    this.formulario.addControl(
      `pregunta_|_${name}_|_${id}`,
      this.formBuilder.control('', [
        Validators.required,
        Validators.maxLength(200),
        Validators.pattern(exp_invalidos),
      ])
    );
  }

  getNumberPregunta(idPregunta: string): number {
    let index: number = this.preguntaOpciones.findIndex(
      (item) => item.pregunta.idPregunta === idPregunta
    );
    return index + 1;
  }

  getPreguntasSinContestar(): string[] {
    let list = [];

    if (!this.formulario.valid) {
      for (let item in this.formulario.value) {
        if (this.formulario.value[item] === '') {
          let auxItem = item.split('_|_')[1];
          let id = item.split('_|_')[2];

          let pregunta = `${this.getNumberPregunta(id)}. ${auxItem}`;

          list.push(pregunta);
        }
      }
    }
    return list;
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
