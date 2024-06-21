import { AfterViewInit, Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Opcion, PreguntaOpciones } from 'src/app/Models/Pregunta';
import { Chart } from 'chart.js/auto';
import {
  AlertError,
  ChangeRoute,
  FontFamily,
  GetArchivo,
  GetColor,
  GetColors,
  Loading,
  MsgArchivoDescargado,
  MsgErrorArchivo,
  MsgOk,
  SinRegistros,
  TitleErrorArchivo,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { PreguntaService } from 'src/app/services/pregunta.service';
import { MessageService } from 'primeng/api';
import { Reto } from 'src/app/Models/Reto';

@Component({
  selector: 'app-results',
  templateUrl: './results.component.html',
  styleUrls: ['./results.component.css'],
  providers: [MessageService],
})
export class ResultsComponent implements OnInit, AfterViewInit {
  alertError = AlertError();
  loading = Loading();
  getColors = GetColors();
  getColor = GetColor();
  getArchivo = GetArchivo();
  changeRoute = ChangeRoute();

  first: number = 0;
  rows: number = 6; // items por página

  idReto: string = '';
  info: string = '';

  chart: Chart[] = [];

  preguntaOpciones: PreguntaOpciones[] = [
    {
      pregunta: {
        idPregunta: '',
        idReto: '',
        nombre: '',
      },
      opcionList: [
        {
          idOpcion: '',
          idPregunta: '',
          idTipoEntrada: '',
          tipoEntrada: '',
          nombre: '',
          correcta: 0,
          cantVotos: 0,
          valor: 0,
          cantVotosXvalor: 0,
        },
      ],
    },
  ];

  reto: Reto = {
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
    idTipoReto: '',
    tipoReto: '',
    idTipoEncuesta: '',
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
    validadores: 0,
    puedeValidar: 0,
    enEquipo: -1,
    opsRequeridas: 1,
    items: 0,
    estado: 0,
  };

  constructor(
    private route: ActivatedRoute,
    private preguntaServicio: PreguntaService,
    private messageService: MessageService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.loading(true, false);
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    this.cargarData();
  }

  getRouteParams() {
    this.route.queryParams.subscribe((params) => {
      this.idReto = params['reto'];
      if (this.idReto === '' || !params['reto']) {
        this.changeRoute('/404', {});
      }
    });
  }

  cargarData() {
    this.preguntaServicio.getList(-1, this.idReto).subscribe({
      next: (data: any) => {
        let { error, info, list, reto } = data.response;
        if (error === 0) {
          this.preguntaOpciones = list;
          this.reto = reto;

          this.info = SinRegistros;
        } else {
          this.alertError(TitleErrorForm, info);
        }
        this.loading(false, false);
      },
      error: (e) => {
        console.error(e, e.status);
        if (e.status === 401 || e.status === 403) {
          this.router.navigate(['/']);
        } else {
          this.changeRoute('/404', {});
        }
      },
    });
  }

  onExport() {
    if (this.preguntaOpciones.length) {
      if (this.reto.tipoReto === 'Comportamiento') {
        this.exportarArchivoComportamiento();
      } else {
        this.exportarArchivo();
      }
    } else {
      this.alertError(TitleErrorArchivo, SinRegistros);
    }
  }

  exportarArchivo() {
    this.loading(true, false);
    this.preguntaServicio.reporteResultados(-1, this.idReto).subscribe({
      next: (data: any) => {
        let { info, error, file } = data.response;
        if (error === 0) {
          const byteArray = new Uint8Array(
            atob(file)
              .split('')
              .map((char) => char.charCodeAt(0))
          );

          const blob = new Blob([byteArray], {
            type: 'application/vnd.ms-excel',
          });

          const url = window.URL.createObjectURL(blob);
          const a = document.createElement('a');
          a.href = url;
          a.download = 'Resultados.xls';
          document.body.appendChild(a);
          a.click();
          document.body.removeChild(a);
          window.URL.revokeObjectURL(url);

          this.messageService.add({
            severity: 'success',
            summary: MsgOk,
            detail: MsgArchivoDescargado,
          });
        } else {
          this.alertError(TitleErrorArchivo, info);
        }
        this.loading(false, false, 1000);
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

  exportarArchivoComportamiento() {
    this.loading(true, false);
    this.preguntaServicio
      .reporteResultadosComportamiento(-1, this.idReto)
      .subscribe({
        next: (data: any) => {
          let { info, error, file } = data.response;
          if (error === 0) {
            const byteArray = new Uint8Array(
              atob(file)
                .split('')
                .map((char) => char.charCodeAt(0))
            );

            const blob = new Blob([byteArray], {
              type: 'application/vnd.ms-excel',
            });

            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'Resultados.xls';
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            window.URL.revokeObjectURL(url);

            this.messageService.add({
              severity: 'success',
              summary: MsgOk,
              detail: MsgArchivoDescargado,
            });
          } else {
            this.alertError(TitleErrorArchivo, info);
          }
          this.loading(false, false, 1000);
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

  getTotalVotos(options: Opcion[]): number {
    let total: number = 0;

    options.forEach((item) => {
      total += item.cantVotos;
    });

    return total;
  }

  getChartHorizontalBar(options: Opcion[], pregunta: string) {
    let label = 'Cantidad de votos';
    let listOptions: string[] = options.map((item: Opcion) => item.nombre);
    let listCantVotos: number[] = options.map((item: Opcion) => item.cantVotos);

    return {
      type: 'bar',
      data: {
        labels: listOptions,
        datasets: [
          {
            axis: 'y',
            label,
            data: listCantVotos,
            fill: false,
            backgroundColor: this.getColors(listCantVotos.length, 0.3),
            borderWidth: 1,
          },
        ],
      },
      options: {
        indexAxis: 'y',
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            position: '',
          },
          title: {
            display: true,
            text: this.getTextLines(pregunta),
            padding: {
              top: 20,
              bottom: 30,
            },
            font: {
              size: 15,
              family: FontFamily,
              weight: 'normal',
            },
          },
        },
      },
    };
  }

  getChartRadar(options: Opcion[], pregunta: string) {
    let label = 'Cantidad de votos por escala';
    let listOptions: string[] = options.map((item: Opcion) => item.nombre);
    let listCantVotosXvalor: number[] = options.map(
      (item: Opcion) => item.cantVotosXvalor
    );

    let color: string[] = this.getColor(0.2);

    const data = {
      labels: listOptions,
      datasets: [
        {
          label,
          data: listCantVotosXvalor,
          fill: true,
          backgroundColor: color[0],
          borderColor: color[1],
          pointBackgroundColor: color[1],
          pointBorderColor: '#fff',
          pointHoverBackgroundColor: '#fff',
          pointHoverBorderColor: color[1],
        },
      ],
    };

    return {
      type: 'radar',
      data: data,
      options: {
        responsive: true,
        plugins: {
          legend: {
            position: '',
          },
          title: {
            display: true,
            text: this.getTextLines(pregunta),
            padding: {
              top: 20,
              bottom: 30,
            },
            font: {
              size: 15,
              family: FontFamily,
              weight: 'normal',
            },
          },
          filler: {
            propagate: false,
          },
          'samples-filler-analyser': {
            target: 'chart-analyser',
          },
        },
        interaction: {
          intersect: false,
        },
      },
    };
  }

  /* getChartPie(options: Opcion[], pregunta: string) {
    let label = 'Cantidad de votos';
    let listOptions: string[] = options.map((item: Opcion) => item.nombre);
    let listCantVotos: number[] = options.map((item: Opcion) => item.cantVotos);

    if (!this.getTotalVotos(options)) {
      listCantVotos.push(-1);
      label = 'Sin votos';
    }

    return {
      type: 'pie',
      data: {
        labels: listOptions,
        datasets: [
          {
            label,
            data: listCantVotos,
            backgroundColor: this.getColors(listCantVotos.length, 0.2),
            hoverOffset: 4,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            position: 'top',
          },
          title: {
            display: true,
            text: this.getTextLines(pregunta),
            font: {
              size: 17,
              family: FontFamily,
              weight: 'normal',
            },
          },
        },
      },
    };
  } */

  getTextLines(texto: string): string[] {
    const palabras: string[] = texto.split(' ');
    const grupos: string[] = [];
    for (let i = 0; i < palabras.length; i += 7) {
      grupos.push(palabras.slice(i, i + 7).join(' '));
    }

    return grupos;
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
