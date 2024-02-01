import { Component, OnInit } from '@angular/core';
import { Categoria } from 'src/app/Models/Adicional';

@Component({
  selector: 'app-view-categoria',
  templateUrl: './view-categoria.component.html',
  styleUrls: ['./view-categoria.component.css'],
})
export class ViewCategoriaComponent implements OnInit {
  categoria: Categoria[] = [
    {
      idCategoria: '',
      nombre: 'Deportes',
      descripcion: 'desc de deportes',
    },
  ];

  ngOnInit(): void {}
}
