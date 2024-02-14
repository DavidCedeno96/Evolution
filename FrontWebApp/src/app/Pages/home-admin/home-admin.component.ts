import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Chart, ChartType } from 'chart.js/auto';
import { Noticia } from 'src/app/Models/Noticia';
import { Usuario } from 'src/app/Models/Usuario';
import {
  AlertError,
  GetImage,
  Loading,
  MsgError,
  TitleError,
} from 'src/app/Utils/Constants';
import { HomeService } from 'src/app/services/home.service';

@Component({
  selector: 'app-home-admin',
  templateUrl: './home-admin.component.html',
  styleUrls: ['./home-admin.component.css'],
})
export class HomeAdminComponent implements OnInit {
  load = Loading();
  alertError = AlertError();
  getImage = GetImage();

  public chart!: Chart;

  retosCompletados: number = 0;
  medallasConseguidas: number = 0;
  recomensasReclamadas: number = 0;

  noticias: Noticia[] = [];
  usuarios: Usuario[] = [];

  constructor(private homeService: HomeService, private router: Router) {}

  ngOnInit(): void {
    this.load(true, false);
    this.cargarData();
  }

  cargarData() {
    this.homeService.getAdminList().subscribe({
      next: (data: any) => {
        let {
          datasetList,
          noticiasEnTendencia,
          resumenGeneral,
          usuariosMasActivos,
        } = data;
        if (datasetList.error === 0) {
          this.lineChart(datasetList.lista);
        }
        if (noticiasEnTendencia.error === 0) {
          this.noticias = noticiasEnTendencia.lista;
        }
        if (usuariosMasActivos.error === 0) {
          this.usuarios = usuariosMasActivos.lista;
        }
        if (resumenGeneral.error === 0) {
          this.retosCompletados =
            resumenGeneral.resumenGeneral.retosCompletados;
          this.medallasConseguidas =
            resumenGeneral.resumenGeneral.medallasConseguidas;
          this.recomensasReclamadas =
            resumenGeneral.resumenGeneral.recomensasReclamadas;
        }
        this.load(false, false);
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
      labels: [
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
      ],
      datasets: datasetsList,
      /* [
        {
          label: 'Puntos alcanzados 2023',
          data: [0, 59, 80, 81, 56, 55, 40],
          fill: false,
          borderColor: 'rgb(75, 192, 192)',
          tension: 0.1,
        },        
      ] */
    };

    this.chart = new Chart('chart', {
      type: 'line' as ChartType,
      data,
    });
  }
}
