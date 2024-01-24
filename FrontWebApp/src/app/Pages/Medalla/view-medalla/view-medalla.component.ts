import { Component } from '@angular/core';
import { Medalla } from 'src/app/Models/Medalla';

@Component({
  selector: 'app-view-medalla',
  templateUrl: './view-medalla.component.html',
  styleUrls: ['./view-medalla.component.css'],
})
export class ViewMedallaComponent {
  medalla: Medalla[] = [
    {
      idMedalla: '',
      nombre: 'medalla1',
      descripcion: 'descripcion de la medalla 1',
      imagen: 'medalla.jpg',
      totalUsuarios: 23,
      idCondicion: '',
      condicion: 'cumplir 5 retos',
      estado: 1,
    },
  ];
}
