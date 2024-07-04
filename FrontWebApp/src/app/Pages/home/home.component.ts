import {
  AfterViewInit,
  Component,
  ElementRef,
  OnInit,
  QueryList,
  ViewChildren,
} from '@angular/core';
import { Router } from '@angular/router';
import { Chart, ChartType } from 'chart.js/auto';
import { ConfigInicio } from 'src/app/Models/Configuracion';
import { Usuario_Equipo } from 'src/app/Models/Equipo';
import { Licencia } from 'src/app/Models/Licencia';
import { Medalla } from 'src/app/Models/Medalla';
import { Nivel, Usuario_Nivel } from 'src/app/Models/Nivel';
import { Noticia } from 'src/app/Models/Noticia';
import { Recompensa } from 'src/app/Models/Recompensa';
import { ResumenGeneral } from 'src/app/Models/ResumenGeneral';
import { Reto, Usuario_Reto } from 'src/app/Models/Reto';
import { Usuario } from 'src/app/Models/Usuario';
import {
  AlertError,
  ChangeRoute,
  DateCompare,
  GetImage,
  Loading,
  MsgError,
  TitleError,
  TitleErrorForm,
  PLAY_MOVE,
} from 'src/app/Utils/Constants';
import { HomeService } from 'src/app/services/home.service';
import { NivelService } from 'src/app/services/nivel.service';
import { UsuarioService } from 'src/app/services/usuario.service';

declare var $: any;

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css'],
})
export class HomeComponent implements OnInit, AfterViewInit {
  alertError = AlertError();
  loading = Loading();
  getImage = GetImage();
  dateCompare = DateCompare();
  changeRoute = ChangeRoute();
  playMoveUrl = PLAY_MOVE;

  @ViewChildren('canvas') canvas!: QueryList<ElementRef>;

  customOuterStrokeColor: string = '';
  chart: Chart[] = [];

  rol: string = '';
  idEquipo: string = '';

  usuario: Usuario = {
    idUsuario: '',
    nombre: '',
    apellido: '',
    correo: '',
    id: '',
    paisCode: '',
    paisIso2: '',
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

  configInicioItems: ConfigInicio[] = [];
  resumenG: ResumenGeneral = {
    medallasConseguidas: 0,
    recomensasReclamadas: 0,
    retosCompletados: 0,
  };
  noticias: Noticia[] = [];
  medallas: Medalla[] = [];
  usuariosActivos: Usuario[] = [];
  retosTerminados: Usuario_Reto[] = [];
  miNivel: Nivel[] = [];
  nivelProx: Nivel = {
    idNivel: '',
    nombre: '',
    descripcion: '',
    puntosNecesarios: 100,
    imagen: '',
    totalUsuarios: 0,
    estado: 0,
    fechaCreacion: new Date(),
  };
  tieneNivelProx: boolean = false;
  porcentajeNivel: number = 0;

  recompensas: Recompensa[] = [];
  usuariosRanking: Usuario_Reto[] = [];
  equiposRanking: Usuario_Equipo[] = [];
  retosAsignados: Usuario_Reto[] = [];
  licencias: Licencia[] = [];
  urXvalidar: Usuario_Reto[] = [];

  indexMesesChart: number = 0;
  auxMeses: string[] = [];
  meses: string[] = [
    'enero',
    'febrero',
    'marzo',
    'abril',
    'mayo',
    'junio',
    'julio',
    'agosto',
    'septiembre',
    'octubre',
    'noviembre',
    'diciembre',
  ];

  constructor(
    private el: ElementRef,
    private usuarioServicio: UsuarioService,
    private homeService: HomeService,
    private nivelService: NivelService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.loading(true, false);
    this.rol = this.usuarioServicio.getRol();
    this.cargarData();
  }

  ngAfterViewInit(): void {
    setTimeout(() => {
      if (this.porcentajeNivel >= 100 && this.tieneNivelProx) {
        this.nivelService.createUsuarioNivel(this.setData()).subscribe({
          next: (data: any) => {
            let { error, info } = data.response;
            if (error === 0) {
              this.cargarData();
            } else {
              this.alertError(TitleError, info);
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
      } else {
        this.loading(false, false);
      }

      this.initMasonry();
    }, 300);
  }

  cargarData() {
    this.homeService.getUserList().subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          let datasetList: any[] = [];
          let fechaHoy = new Date();
          fechaHoy.setHours(0, 0, 0, 0);

          this.configInicioItems = lista[0];
          this.usuario = lista[1];
          this.resumenG = lista[2];
          this.noticias = lista[3];
          this.medallas = lista[4];
          datasetList = lista[5];
          this.usuariosActivos = lista[6];
          this.retosTerminados = lista[7];
          this.miNivel = lista[8];
          if (lista[9]) {
            this.nivelProx = lista[9];
            this.tieneNivelProx = true;
          }
          this.porcentajeNivel = lista[10];
          this.recompensas = lista[11];
          this.usuariosRanking = lista[12];
          this.equiposRanking = lista[13];
          this.idEquipo = lista[14];
          this.retosAsignados = lista[15];
          this.licencias = lista[16];
          this.urXvalidar = lista[17];

          datasetList.forEach((item: any) => {
            if (item.data.length > this.indexMesesChart) {
              this.indexMesesChart = item.data.length;
            }
          });
          for (let i = 0; i < this.indexMesesChart; i++) {
            this.auxMeses.push(this.meses[i]);
          }
          this.lineChart(datasetList);
          this.getPrimaryColor();
        } else {
          this.alertError(TitleErrorForm, info);
        }
      },
      error: (e) => {
        console.error(e);
        if (e.status === 401 || e.status === 403) {
          this.router.navigate(['/']);
        } else {
          this.alertError(TitleError, MsgError);
          this.changeRoute('/404', {});
        }
      },
    });
  }

  // Son los puntos de todos los usuarios
  lineChart(datasetsList: any[]) {
    const data = {
      labels: this.auxMeses,
      datasets: datasetsList,
    };

    setTimeout(() => {
      this.canvas.forEach((item: ElementRef) => {
        let i = 0;
        let context = (item.nativeElement as HTMLCanvasElement).getContext(
          '2d'
        );
        this.chart[i] = new Chart(context!, {
          type: 'line' as ChartType,
          data,
          options: {
            responsive: true,
            scales: {
              y: {
                display: true,
                title: {
                  display: true,
                  text: 'Puntos',
                },
              },
            },
          },
        });
        i += 1;
      });
    }, 500);
  }

  setData(): Usuario_Nivel {
    let un: Usuario_Nivel;

    un = {
      idNivel: this.nivelProx.idNivel,
      idUsuario: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    };

    return un!;
  }

  irAVista(vista: string) {
    switch (vista) {
      case 'noticia': {
        if (this.usuario.idRol === 'adm' || this.usuario.idRol === 'sadm') {
          this.changeRoute('/view-noticia', {});
        } else {
          this.changeRoute('/user-noticia', {});
        }
        break;
      }
      case 'recompensa': {
        if (this.usuario.idRol === 'adm' || this.usuario.idRol === 'sadm') {
          this.changeRoute('/view-recompensa', {});
        } else {
          this.changeRoute('/user-recompensa', {});
        }
        break;
      }
      case 'usuario': {
        if (this.usuario.idRol === 'adm' || this.usuario.idRol === 'sadm') {
          this.changeRoute('/view-user', {});
        }
        break;
      }
      case 'medalla': {
        if (this.usuario.idRol === 'adm' || this.usuario.idRol === 'sadm') {
          this.changeRoute('/view-medalla', {});
        } else {
          this.changeRoute('/user-medalla', {});
        }
        break;
      }
      case 'retos': {
        if (this.usuario.idRol === 'adm' || this.usuario.idRol === 'sadm') {
          this.changeRoute('/view-reto', {});
        } else {
          this.changeRoute('/user-reto', {});
        }
        break;
      }
      case 'retosXvalidar': {
        if (this.usuario.idRol === 'adm' || this.usuario.idRol === 'sadm') {
          this.changeRoute('/view-reto', {});
        } else {
          this.changeRoute('/validaciones', {});
        }
        break;
      }
      case 'ranking': {
        this.changeRoute('/ranking-users', {});
        break;
      }
      case 'rankingXequipos': {
        this.changeRoute('/ranking-teams', {});
        break;
      }
      case 'perfilRedSocial': {
        this.changeRoute('/red-social-perfil', {});
        break;
      }
    }
  }

  getEstadoFecha(reto: Reto): number {
    let fechaHoy = new Date();
    fechaHoy.setHours(0, 0, 0, 0);

    if (
      (new Date(reto.fechaApertura) >= fechaHoy &&
        this.dateCompare(reto.fechaApertura) !== 'N/A') ||
      (new Date(reto.fechaCierre) < fechaHoy &&
        this.dateCompare(reto.fechaCierre) !== 'N/A')
    ) {
      return 0;
    } else {
      return 1;
    }
  }

  getPrimaryColor() {
    this.customOuterStrokeColor = window
      .getComputedStyle(this.el.nativeElement)
      .getPropertyValue('--Primario');
  }

  private initMasonry() {
    $('.masonry-grid').masonry({
      itemSelector: '.masonry-grid-item',
      columnWidth: '.masonry-grid-item',
      percentPosition: true,
    });
  }
}
