import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-user-noticia',
  templateUrl: './user-noticia.component.html',
  styleUrls: ['./user-noticia.component.css'],
})
export class UserNoticiaComponent implements OnInit {
  verTxtComentario: boolean = false;

  ngOnInit(): void {}

  addReaccion(tipo: string) {
    if (tipo === 'like') {
      console.log('dando like');
    }

    if (tipo === 'comentario') {
      this.verTxtComentario = !this.verTxtComentario;
      console.log('Abrir el div de agregar el comentario');
    }
  }

  like() {}

  comentar() {
    console.log('COMENTANDO...');
  }
}
