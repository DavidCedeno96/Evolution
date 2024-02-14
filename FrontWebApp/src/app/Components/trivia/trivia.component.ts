import { AfterViewInit, Component, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Pregunta, PreguntaOpciones } from 'src/app/Models/Pregunta';
import { Reto } from 'src/app/Models/Reto';
import {
  AlertError,
  Loading,
  MsgError,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { PreguntaService } from 'src/app/services/pregunta.service';
import { RetoService } from 'src/app/services/reto.service';

@Component({
  selector: 'app-trivia',
  templateUrl: './trivia.component.html',
  styleUrls: ['./trivia.component.css'],
})
export class TriviaComponent implements OnInit, AfterViewInit, OnDestroy {
  load = Loading();
  alertError = AlertError();

  preguntaActual: number = 0;
  nextText: string = 'Siguiente';
  nextButonDisable: boolean = false;
  opCorrecta: boolean = false;
  verOpCalificacion: boolean = false;
  selectedIndex: number = 0;

  idReto: string = '';
  vidas: number[] = [];
  muertes: number[] = [];
  tiempoRestante: number = 0;
  contador: any;
  puntosPorPregunta: number = 0;
  puntajeTotal: number = 0;

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
    imagen: '',
    idTipoReto: '',
    tipoReto: '',
    idComportamiento: '',
    comportamiento: '',
    estado: 0,
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
          nombre: '1) Tiburón blanco; 2) elefante; 3) escorpión',
          correcta: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '1) Leon; 2) elefante; 3) escorpión',
          correcta: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '1) Hiena; 2) Oso polar; 3) Lobo gris',
          correcta: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '1) Tigre; 2) águila; 3) gato',
          correcta: 1,
        },
      ],
    },
  ];

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private preguntaServicio: PreguntaService,
    private retoService: RetoService
  ) {}

  ngOnInit(): void {
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    this.load(true, false);
    this.cargarReto();
  }

  ngOnDestroy(): void {
    clearInterval(this.contador); // detiene el contador
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
    this.retoService.getItem(-1, this.idReto).subscribe({
      next: (data: any) => {
        let { error, reto } = data.response;
        if (error === 0) {
          this.reto = reto;
          this.vidas = Array(reto.vidas).fill(1);
          this.cargarPreguntas();
        } else {
          history.back();
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
          this.puntosPorPregunta = this.reto.puntosRecompensa / list.length;
          this.iniciarContador();
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

  next() {
    clearInterval(this.contador);

    if (this.preguntaActual === this.preguntaOpciones.length - 1) {
      this.opCalificacion(true, false);
      setTimeout(() => {
        //this.opCalificacion(false, true);
        this.finalizarTrivia();
      }, 2500);
    }
    if (this.preguntaActual < this.preguntaOpciones.length - 1) {
      this.opCalificacion(true, false);

      setTimeout(() => {
        if (!this.vidas.length) {
          this.finalizarTrivia();
        } else {
          this.preguntaActual += 1;
          this.iniciarContador();
        }

        this.opCalificacion(false, true);

        if (this.preguntaActual === this.preguntaOpciones.length - 1) {
          this.nextText = 'Finalizar';
        }
      }, 2500);
    }
  }

  calificarOpcion(index: number, correcta: number) {
    this.selectedIndex = index;
    if (correcta === 1) {
      this.opCorrecta = true;
    } else {
      this.opCorrecta = false;
    }
  }

  cambiarTextColor(index: number): string {
    if (this.selectedIndex > 0 && this.selectedIndex === index) {
      if (this.opCorrecta && this.verOpCalificacion) {
        return 'fw-semibold text-success';
      } else if (this.verOpCalificacion) {
        return 'fw-semibold text-danger text-decoration-line-through';
      }
    } else if (this.selectedIndex === 0 && this.verOpCalificacion) {
      return 'fw-semibold text-danger';
    }
    return 'text-body';
  }

  opCalificacion(btn_Op: boolean, index0: boolean) {
    this.nextButonDisable = btn_Op;
    this.verOpCalificacion = btn_Op;
    if (index0) {
      this.selectedIndex = 0;
    }

    if (btn_Op) {
      this.validarPregunta();
    }
  }

  validarPregunta() {
    if (!this.opCorrecta) {
      this.vidas.pop();
      this.muertes.push(1);
    } else {
      this.puntajeTotal += this.puntosPorPregunta;
    }
  }

  iniciarContador() {
    this.tiempoRestante = this.reto.tiempo_ms;
    this.contador = setInterval(() => {
      this.tiempoRestante -= 1000;
      if (this.tiempoRestante == 1000) {
        this.nextButonDisable = true;
      } else if (this.tiempoRestante < 1) {
        this.next();
        clearInterval(this.contador); // detiene el contador
      }
    }, 1000); // Actualiza cada segundo
  }

  finalizarTrivia() {
    clearInterval(this.contador); // detiene el contador
    console.log('puntaje total', this.puntajeTotal);
    console.log('FINALIZANDO TRIVIA');
  }
}
