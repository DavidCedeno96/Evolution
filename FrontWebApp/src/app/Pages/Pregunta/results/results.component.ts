import { AfterViewInit, Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Opcion, PreguntaOpciones } from 'src/app/Models/Pregunta';
import { Chart } from 'chart.js/auto';
import {
  AlertError,
  GetArchivo,
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
  getArchivo = GetArchivo();

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
        },
      ],
    },
  ];

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
        history.back();
      }
    });
  }

  cargarData() {
    this.preguntaServicio.getList(-1, this.idReto).subscribe({
      next: (data: any) => {
        let { error, info, list } = data.response;
        if (error === 0) {
          this.preguntaOpciones = list;

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
          history.back();
        }
      },
    });
  }

  exportarArchivo() {
    if (this.preguntaOpciones.length) {
      this.loading(true, false);
      this.preguntaServicio.reporteResultados(-1, this.idReto).subscribe({
        next: (data: any) => {
          let { info, error } = data.response;
          if (error === 0) {
            let url = this.getArchivo(info, 'Pregunta');
            const element = document.createElement('a');
            element.download = `Preguntas.xls`;
            element.href = url;
            element.click();

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
            this.loading(false, false, 600);
            this.alertError(TitleErrorArchivo, MsgErrorArchivo);
          }
        },
      });
    } else {
      this.alertError(TitleErrorArchivo, SinRegistros);
    }
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
              family:
                "system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'",
              weight: 'normal',
            },
          },
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
              family:
                "system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'",
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
