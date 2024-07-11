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
    idTipoEncuesta: '7c8c2672-2233-486a-a184-f0b51eb4a331',
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
    opsRequeridas: 0,
    validadores: 0,
    puedeValidar: 0,
    enEquipo: 0,
    items: 0,
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
        this.changeRoute('/404', {});
      }
      this.id = idReto;
    });
  }

  cargarData(idReto: string) {
    this.retoService.getUsuario_RetoByIdUsuarioYIdReto(idReto).subscribe({
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
          if (ur.completado > 0) {
            this.changeRoute('fin-reto', { reto: ur.reto.idReto });
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
          this.changeRoute('/404', {});
        }
      },
    });
  }

  comenzar(reto: Reto) {
    if (this.reto.totalPreguntas > 0 || reto.tipoReto === 'Recolección') {
      this.changeRoute('/juego-reto', { reto: reto.idReto });
    } else {
      this.alertError('Error', 'El reto no tiene preguntas');
    }
  }
}
