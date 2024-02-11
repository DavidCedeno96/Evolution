import { Component, OnInit } from '@angular/core';
import { Chart, ChartType } from 'chart.js/auto';

@Component({
  selector: 'app-home-admin',
  templateUrl: './home-admin.component.html',
  styleUrls: ['./home-admin.component.css'],
})
export class HomeAdminComponent implements OnInit {
  public chart!: Chart;

  chartList2023: number[] = [0, 59, 80, 81, 56, 55, 40];

  ngOnInit(): void {
    this.lineChart();
  }

  // Son los puntos de todos los usuarios
  lineChart() {
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
      datasets: [
        {
          label: 'Puntos alcanzados 2023',
          data: this.chartList2023,
          fill: false,
          borderColor: 'rgb(75, 192, 192)',
          tension: 0.1,
        },
        {
          label: 'Puntos alcanzados 2024',
          data: [23, 30, 90, 40, 87, 20, 10],
          fill: false,
          borderColor: 'rgb(75, 40, 30)',
          tension: 0.1,
        },
      ],
    };

    this.chart = new Chart('chart', {
      type: 'line' as ChartType,
      data,
    });
  }
}
