import { AfterViewInit, Component, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { PreguntaOpciones } from 'src/app/Models/Pregunta';
import { Reto, Usuario_Reto } from 'src/app/Models/Reto';
import { Usuario } from 'src/app/Models/Usuario';
import {
  AlertError,
  AlertSuccess,
  ChangeRoute,
  DateCompare,
  FormatTiempo,
  Loading,
  MsgError,
  ReproducirSonido,
  SoundQuizCorrect,
  SoundQuizIncorrect,
  SoundQuizVictory,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { PreguntaService } from 'src/app/services/pregunta.service';
import { RetoService } from 'src/app/services/reto.service';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-trivia',
  templateUrl: './trivia.component.html',
  styleUrls: ['./trivia.component.css'],
})
export class TriviaComponent implements OnInit, AfterViewInit, OnDestroy {
  load = Loading();
  alertError = AlertError();
  alertSuccess = AlertSuccess();
  dateCompare = DateCompare();
  formatTiempo = FormatTiempo();
  reproducirSonido = ReproducirSonido();
  changeRoute = ChangeRoute();

  preguntaActual: number = 0;
  nextText: string = 'Siguiente';
  nextButonDisable: boolean = false;
  opCorrecta: boolean = false;
  verOpCalificacion: boolean = false;
  selectedIndex: number = 0;

  idReto: string = '';
  retoConVidas: boolean = false;
  vidas: number[] = [1];
  muertes: number[] = [];
  tiempoRestante: number = 0;
  formatTiempoRestante: string = '';
  tiempoTotal: number = 0;
  termporizador: any;
  contador: any;
  porcentajePorPregunta: number = 0;
  porcentajeTotal: number = 0;

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
    totalPreguntas: 0,
    usuariosAsignados: 0,
    equiposAsignados: 0,
    enEquipo: 0,
    estado: 0,
    opsRequeridas: 0,
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
          nombre: '1) Tiburón blanco; 2) elefante; 3) escorpión',
          correcta: 0,
          cantVotos: 0,
          valor: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '1) Leon; 2) elefante; 3) escorpión',
          correcta: 0,
          cantVotos: 0,
          valor: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '1) Hiena; 2) Oso polar; 3) Lobo gris',
          correcta: 0,
          cantVotos: 0,
          valor: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '1) Tigre; 2) águila; 3) gato',
          correcta: 1,
          cantVotos: 0,
          valor: 0,
        },
      ],
    },
  ];

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private preguntaServicio: PreguntaService,
    private retoService: RetoService,
    private usuarioService: UsuarioService
  ) {}

  ngOnInit(): void {
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    this.load(true, false);
    this.cargarReto();
  }

  ngOnDestroy(): void {
    clearInterval(this.termporizador); // detiene el termporizador
    clearInterval(this.contador);
    this.usuarioService.startWatching();
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
            if (ur.reto.vidas > 0) {
              this.retoConVidas = true;
              this.vidas = Array(ur.reto.vidas).fill(1);
            }

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
          if (this.reto.comportamientoPregunta === 'Aleatorio') {
            this.randomPreguntaOpciones = list;
            this.reordenarListaRandom();
            this.preguntaOpciones = this.randomPreguntaOpciones;
          } else {
            this.preguntaOpciones = list;
          }
          this.porcentajePorPregunta = 100 / list.length;
          this.formatTiempoRestante = this.formatTiempo(this.tiempoRestante);
          this.iniciarTemporizador();
          this.iniciarTiempo();

          this.usuarioService.clearWatching();
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

  reordenarListaRandom(): void {
    for (let i = this.randomPreguntaOpciones.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [this.randomPreguntaOpciones[i], this.randomPreguntaOpciones[j]] = [
        this.randomPreguntaOpciones[j],
        this.randomPreguntaOpciones[i],
      ];
    }
  }

  siguientePregunta() {
    //clearInterval(this.termporizador);
    this.pauseTemporizador();
    if (this.opCorrecta) {
      this.reproducirSonido(SoundQuizCorrect);
    } else {
      this.reproducirSonido(SoundQuizIncorrect);
    }

    if (this.preguntaActual === this.preguntaOpciones.length - 1) {
      this.opCalificacion(true, false);
      setTimeout(() => {
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
          this.iniciarTemporizador();
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
      if (this.opCorrecta) {
        this.porcentajeTotal += this.porcentajePorPregunta;
      } else if (this.retoConVidas) {
        this.vidas.pop();
        this.muertes.push(1);
      }
    }
  }

  iniciarTemporizador() {
    this.tiempoRestante = this.reto.tiempo_ms;
    this.termporizador = setInterval(() => {
      this.tiempoRestante -= 1000;
      this.formatTiempoRestante = this.formatTiempo(this.tiempoRestante);
      //console.log(this.tiempoRestante);
      if (this.tiempoRestante == 1000) {
        this.nextButonDisable = true;
      } else if (this.tiempoRestante < 1) {
        clearInterval(this.termporizador); // detiene el termporizador
        clearInterval(this.contador); // detiene el contador
        this.finalizarTrivia();
        //this.siguientePregunta();
      }
    }, 1000); // Actualiza cada segundo
  }

  pauseTemporizador() {
    this.reto.tiempo_ms = this.tiempoRestante;
    clearInterval(this.termporizador);
  }

  iniciarTiempo() {
    this.contador = setInterval(() => {
      this.tiempoTotal += 1000;
    }, 1000); // Actualiza cada segundo
  }

  finalizarTrivia() {
    this.load(true, false);
    clearInterval(this.termporizador); // detiene el termporizador
    clearInterval(this.contador); // detiene el contador

    //console.log('FINALIZANDO TRIVIA');
    this.retoService.updateUsuario_retoTrivia(this.setData()).subscribe({
      next: (data: any) => {
        let { error, info } = data.response;
        if (error === 0) {
          this.reproducirSonido(SoundQuizVictory);

          /* let msjPuntosCreditos = `<span class="d-block">Puntos Obtenidos: ${
            this.porcentajeTotal >= this.reto.criterioMinimo
              ? this.reto.puntosRecompensa
              : 0
          }</span>
          <span class="d-block">Créditos Obtenidos: ${
            this.porcentajeTotal >= this.reto.criterioMinimo
              ? this.reto.creditosObtenidos
              : 0
          }</span>
          `;

          let msjPuntos = `<span class="d-block">Puntos Obtenidos: ${
            this.porcentajeTotal >= this.reto.criterioMinimo
              ? this.reto.puntosRecompensa
              : 0
          }</span>`;

          this.alertSuccess(
            'Reto Terminado',
            this.reto.creditosObtenidos ? msjPuntosCreditos : msjPuntos
          ); */

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
  }

  setData(): Usuario_Reto {
    let usuarioReto: Usuario_Reto;
    let usuario: Usuario;
    let reto: Reto;

    usuario = {
      idUsuario: '7c8c2672-2233-486a-a184-f0b51eb4a331',
      nombre: '',
      apellido: '',
      correo: '',
      id: '',
      celular: '',
      foto: '',
      idRol: '',
      rol: '',
      idPais: '',
      pais: '',
      idCiudad: '',
      ciudad: '',
      idEmpresa: '',
      empresa: '',
      idArea: '',
      area: '',
      contrasena: '',
      puntos: 0,
      creditos: 0,
      estado: 0,
    };

    reto = {
      idReto: this.idReto,
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
      estado: 0,
      totalPreguntas: 0,
      usuariosAsignados: 0,
      equiposAsignados: 0,
      enEquipo: 0,
      opsRequeridas: 0,
    };

    usuarioReto = {
      usuario: usuario,
      reto: reto,
      puntos:
        this.porcentajeTotal >= this.reto.criterioMinimo
          ? this.reto.puntosRecompensa
          : 0,
      tiempo: this.tiempoTotal,
      vidas: this.retoConVidas ? this.vidas.length : -1,
      totalRetos: 0,
      completado: 1,
      posicion: 0,
      tieneEquipo: 0,
      fechaCreacion: new Date(),
      fechaModificacion: new Date(),
    };

    return usuarioReto!;
  }
}
