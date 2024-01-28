import { Component, OnInit } from '@angular/core';
import { Noticia } from 'src/app/Models/Noticia';
import { DateFormat } from 'src/app/Utils/Constants';

@Component({
  selector: 'app-view-noticia',
  templateUrl: './view-noticia.component.html',
  styleUrls: ['./view-noticia.component.css'],
})
export class ViewNoticiaComponent implements OnInit {
  dateFormat = DateFormat();

  noticia: Noticia[] = [
    {
      idNoticia: '',
      titular: 'Titular1',
      descripcion: 'desc1',
      url: 'https://pixijs.com',
      imagen: 'img.jpg',
      categoria: 'Deportes',
      fechaPublicacion: new Date(),
      totalLikes: 10,
      totalComents: 3,
    },
  ];

  constructor() {}

  ngOnInit(): void {}

  onNavigate(url: string) {
    window.open(url, '_blank');
  }
}
