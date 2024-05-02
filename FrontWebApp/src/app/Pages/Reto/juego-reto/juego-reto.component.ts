import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Reto } from 'src/app/Models/Reto';
import { DateCompare, Loading } from 'src/app/Utils/Constants';
import { RetoService } from 'src/app/services/reto.service';

@Component({
  selector: 'app-juego-reto',
  templateUrl: './juego-reto.component.html',
  styleUrls: ['./juego-reto.component.css'],
})
export class JuegoRetoComponent implements OnInit {
  load = Loading();
  dateCompare = DateCompare();

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
    private route: ActivatedRoute, // private router: Router,
    private retoService: RetoService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.load(true, false);
    this.getRouteParams();
    this.getData();
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

  getData() {
    this.retoService.getUsuario_RetoByIdUsuarioYIdReto(this.id).subscribe({
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
          }
        } else {
          this.router.navigate(['/user-reto']);
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
}
