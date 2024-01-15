import { Component, OnInit } from '@angular/core';
import { Chart, ChartType } from 'chart.js/auto';

@Component({
  selector: 'app-home-admin',
  templateUrl: './home-admin.component.html',
  styleUrls: ['./home-admin.component.css'],
})
export class HomeAdminComponent implements OnInit {
  public chart!: Chart;

  ngOnInit(): void {
    this.lineChart();
  }

  lineChart() {
    const data = {
      labels: ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio'],
      datasets: [
        {
          label: 'Incremento del aprendizaje',
          data: [65, 59, 80, 81, 56, 55, 40],
          fill: false,
          borderColor: 'rgb(75, 192, 192)',
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
