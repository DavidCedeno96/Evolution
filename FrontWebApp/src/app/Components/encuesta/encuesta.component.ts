import { AfterViewInit, Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { PreguntaOpciones } from 'src/app/Models/Pregunta';
import { Reto } from 'src/app/Models/Reto';
import {
  AlertError,
  DateCompare,
  Loading,
  MsgError,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { PreguntaService } from 'src/app/services/pregunta.service';
import { RetoService } from 'src/app/services/reto.service';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-encuesta',
  templateUrl: './encuesta.component.html',
  styleUrls: ['./encuesta.component.css'],
})
export class EncuestaComponent implements OnInit, AfterViewInit {
  load = Loading();
  dateCompare = DateCompare();
  alertError = AlertError();

  idReto: string = '';

  first: number = 0;
  rows: number = 1; // items por página

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
    idComportamiento: '',
    comportamientoPregunta: '',
    totalPreguntas: 0,
    usuariosAsignados: 0,
    equiposAsignados: 0,
    enEquipo: 0,
    estado: 0,
  };

  randomPreguntaOpciones: PreguntaOpciones[] = [];
  preguntaOpciones: PreguntaOpciones[] = [
    {
      reto: {
        idReto: '7c8c2672-2233-486a-a184-f0b51eb4a331',
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
        idComportamiento: '7c8c2672-2233-486a-a184-f0b51eb4a331',
        comportamientoPregunta: '',
        estado: 0,
        totalPreguntas: 0,
        usuariosAsignados: 0,
        equiposAsignados: 0,
        enEquipo: 0,
      },
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
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '1) Leon; 2) elefante; 3) escorpión',
          correcta: 0,
          cantVotos: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '1) Hiena; 2) Oso polar; 3) Lobo gris',
          correcta: 0,
          cantVotos: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '1) Tigre; 2) águila; 3) gato',
          correcta: 1,
          cantVotos: 0,
        },
      ],
    },
  ];

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private preguntaServicio: PreguntaService,
    private retoService: RetoService //private usuarioService: UsuarioService
  ) {}

  ngOnInit(): void {
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    this.load(true, false);
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
        console.log(data);

        let { error, info, list } = data.response;
        if (error === 0) {
          if (this.reto.comportamientoPregunta === 'Aleatorio') {
            this.randomPreguntaOpciones = list;
            this.reordenarListaRandom();
            this.preguntaOpciones = this.randomPreguntaOpciones;
          } else {
            this.preguntaOpciones = list;
          }

          console.log(this.preguntaOpciones);

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

  reordenarListaRandom(): void {
    for (let i = this.randomPreguntaOpciones.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [this.randomPreguntaOpciones[i], this.randomPreguntaOpciones[j]] = [
        this.randomPreguntaOpciones[j],
        this.randomPreguntaOpciones[i],
      ];
    }
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
  }
}
