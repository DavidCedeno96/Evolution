import { Component, OnInit } from '@angular/core';
import { Nivel } from 'src/app/Models/Nivel';

@Component({
  selector: 'app-view-nivel',
  templateUrl: './view-nivel.component.html',
  styleUrls: ['./view-nivel.component.css'],
})
export class ViewNivelComponent implements OnInit {
  nivel: Nivel[] = [
    {
      idNivel: '',
      nombre: 'Nivel 1',
      descripcion: 'Este es para el nivel 1',
      puntosNecesarios: 23,
      imagen: 'nivel.jpg',
      totalUsuarios: 10,
      estado: 1,
    },
  ];

  ngOnInit(): void {}
}
