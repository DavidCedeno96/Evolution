import { Component, OnInit } from '@angular/core';
import { Noticia } from 'src/app/Models/Noticia';

@Component({
  selector: 'app-view-noticia',
  templateUrl: './view-noticia.component.html',
  styleUrls: ['./view-noticia.component.css'],
})
export class ViewNoticiaComponent implements OnInit {
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
  ngOnInit(): void {}

  formatDate(fecha: Date): string {
    //const opciones = { weekday: 'long', year: 'numeric', month: 'short', day: 'numeric' };
    //let auxFecha = fecha.toLocaleString('es-es', opciones);
    return fecha.toLocaleDateString('en-US');
  }

  onNavigate(url: string) {
    window.open(url, '_blank');
  }
}
