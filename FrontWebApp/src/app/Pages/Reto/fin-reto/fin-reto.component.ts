import { AfterViewInit, Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Reto, Usuario_Reto } from 'src/app/Models/Reto';
import { Usuario } from 'src/app/Models/Usuario';
import { GetImage, Loading } from 'src/app/Utils/Constants';
import { RetoService } from 'src/app/services/reto.service';

@Component({
  selector: 'app-fin-reto',
  templateUrl: './fin-reto.component.html',
  styleUrls: ['./fin-reto.component.css'],
})
export class FinRetoComponent implements OnInit, AfterViewInit {
  load = Loading();
  getImage = GetImage();

  id: string = '';

  usuario: Usuario = {
    idUsuario: '',
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

  ur: Usuario_Reto = {
    usuario: this.usuario,
    reto: this.reto,
    puntos: 0,
    tiempo: 0,
    vidas: 0,
    totalRetos: 0,
    posicion: 0,
    completado: 0,
    tieneEquipo: 0,
    fechaCreacion: new Date(),
    fechaModificacion: new Date(),
  };

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private retoService: RetoService
  ) {}

  ngOnInit(): void {
    this.load(true, false);
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
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
          this.ur = ur;

          let estado: number = 1;

          if (ur.reto.completado === 0) {
            estado = 0;
          }

          if (estado === 0) {
            this.router.navigate(['/user-reto']);
          } else {
            //this.formatTiempo_ms = this.formatTiempo(ur.reto.tiempo_ms);
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
}
