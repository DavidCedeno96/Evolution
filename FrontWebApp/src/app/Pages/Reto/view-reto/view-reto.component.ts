import { Component, OnInit } from '@angular/core';
import { Reto } from 'src/app/Models/Reto';
import { DateFormat } from 'src/app/Utils/Constants';

@Component({
  selector: 'app-view-reto',
  templateUrl: './view-reto.component.html',
  styleUrls: ['./view-reto.component.css'],
})
export class ViewRetoComponent implements OnInit {
  dateFormat = DateFormat();

  reto: Reto[] = [
    {
      idReto: '',
      nombre: 'Reto1',
      fechaApertura: new Date(),
      fechaCierre: new Date(),
      vidas: 3,
      tiempo_ms: 3600,
      puntosRecompensa: 10,
      creditosObtenidos: 23,
      instrucciones: '',
      imagen: 'imgreto.png',
      idTipoReto: '',
      tipoReto: 'Trivia',
      idComportamiento: '',
      comportamiento: 'aleatoria',
      estado: 1,
    },
    {
      idReto: '',
      nombre: 'Reto1',
      fechaApertura: new Date(),
      fechaCierre: new Date(),
      vidas: 3,
      tiempo_ms: 3600,
      puntosRecompensa: 10,
      creditosObtenidos: 23,
      instrucciones: '',
      imagen: 'imgreto.png',
      idTipoReto: '',
      tipoReto: 'Trivia',
      idComportamiento: '',
      comportamiento: 'aleatoria',
      estado: 1,
    },
  ];
  ngOnInit(): void {}
}
