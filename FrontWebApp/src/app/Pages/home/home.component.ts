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
import { Medalla } from 'src/app/Models/Medalla';
import { Nivel, Usuario_Nivel } from 'src/app/Models/Nivel';
import { Noticia } from 'src/app/Models/Noticia';
import { Recompensa } from 'src/app/Models/Recompensa';
import { ResumenGeneral } from 'src/app/Models/ResumenGeneral';
import { Reto, Usuario_Reto } from 'src/app/Models/Reto';
import { Usuario } from 'src/app/Models/Usuario';
import {
  AlertError,
  DateCompare,
  GetImage,
  Loading,
  MsgError,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { HomeService } from 'src/app/services/home.service';
import { NivelService } from 'src/app/services/nivel.service';
import { UsuarioService } from 'src/app/services/usuario.service';

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

  @ViewChildren('canvas') canvas!: QueryList<ElementRef>;

  chart: Chart[] = [];

  rol: string = '';

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
    posicion: 0,
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
  retosAsignados: Usuario_Reto[] = [];

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
            this.loading(false, false);
            this.alertError(TitleError, MsgError);
          },
        });
      } else {
        this.loading(false, false);
      }
    }, 400);
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
          this.recompensas = lista[10];
          this.usuariosRanking = lista[11];
          this.retosAsignados = lista[12];
          this.porcentajeNivel = lista[13];

          this.retosAsignados.forEach((item: Usuario_Reto) => {
            if (
              new Date(item.reto.fechaApertura) >= fechaHoy &&
              this.dateCompare(item.reto.fechaApertura) !== 'N/A'
            ) {
              item.reto.estado = 0;
            }
            if (
              new Date(item.reto.fechaCierre) < fechaHoy &&
              this.dateCompare(item.reto.fechaCierre) !== 'N/A'
            ) {
              item.reto.estado = 0;
            }
          });

          datasetList.forEach((item: any) => {
            if (item.data.length > this.indexMesesChart) {
              this.indexMesesChart = item.data.length;
            }
          });
          for (let i = 0; i < this.indexMesesChart; i++) {
            this.auxMeses.push(this.meses[i]);
          }
          this.lineChart(datasetList);
        } else {
          this.alertError(TitleErrorForm, info);
        }
        //this.loading(false, false);
      },
      error: (e) => {
        console.error(e);
        if (e.status === 401 || e.status === 403) {
          this.router.navigate(['/']);
        } else {
          this.alertError(TitleError, MsgError);
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
}
