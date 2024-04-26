import { AfterViewInit, Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Reto } from 'src/app/Models/Reto';
import {
  AlertError,
  ChangeRoute,
  DateCompare,
  FormatTiempo,
  GetImage,
  GetTypeTime,
  Loading,
} from 'src/app/Utils/Constants';
import { RetoService } from 'src/app/services/reto.service';

@Component({
  selector: 'app-entrada-reto',
  templateUrl: './entrada-reto.component.html',
  styleUrls: ['./entrada-reto.component.css'],
})
export class EntradaRetoComponent implements OnInit, AfterViewInit {
  load = Loading();
  getImage = GetImage();
  alertError = AlertError();
  changeRoute = ChangeRoute();
  dateCompare = DateCompare();
  formatTiempo = FormatTiempo();
  getTypeTime = GetTypeTime();

  formatTiempo_ms: string = '';
  id: string = '';

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

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private retoService: RetoService
  ) {}

  ngOnInit(): void {
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    this.load(true, false);
    this.cargarData(this.id);
  }

  getRouteParams() {
    this.route.queryParams.subscribe((params) => {
      let idReto = params['reto'];
      if (!params['reto']) {
        history.back();
      }
      this.id = idReto;
    });
  }

  cargarData(idReto: string) {
    this.retoService.getUsuario_RetoByIdUsuarioYIdReto(idReto).subscribe({
      next: (data: any) => {
        //console.log(data);

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
          if (ur.reto.completado === 1) {
            estado = 0;
          }

          if (estado === 0) {
            this.router.navigate(['/user-reto']);
          } else {
            this.formatTiempo_ms = this.formatTiempo(ur.reto.tiempo_ms);
          }
        } else {
          history.back();
        }
        this.load(false, false);
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

  comenzar(idReto: string) {
    if (this.reto.totalPreguntas > 0) {
      this.changeRoute('/juego-reto', { reto: idReto });
    } else {
      this.alertError('Error', 'El reto no tiene preguntas');
    }
  }
}
