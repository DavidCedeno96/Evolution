import { Component, OnInit } from '@angular/core';
import { Recompensa } from 'src/app/Models/Recompensa';

@Component({
  selector: 'app-view-recompensa',
  templateUrl: './view-recompensa.component.html',
  styleUrls: ['./view-recompensa.component.css'],
})
export class ViewRecompensaComponent implements OnInit {
  recompensa: Recompensa[] = [
    {
      idRecompensa: '',
      nombre: 'recomensa 1',
      descripcion: 'descripcion de la recomensa 1',
      imagen: 'img.png',
      cantDisp: 23,
      cantCanje: 4,
      totalUsuarios: 2,
    },
  ];

  ngOnInit(): void {}
}
