import { Component, OnInit } from '@angular/core';
import { Usuario } from 'src/app/Models/Usuario';

@Component({
  selector: 'app-view-user',
  templateUrl: './view-user.component.html',
  styleUrls: ['./view-user.component.css'],
})
export class ViewUserComponent implements OnInit {
  usuarios: Usuario[] = [
    {
      idUsuario: 'osakjdiajsdi2839dj328',
      nombre: 'Dana',
      apellido: 'Nuñez',
      correo: 'dana@correo.com',
      contrasena: 'user123',
      celular: '0998270584',
      foto: 'dana.jpg',
      estado: 1,
      pais: 'Mexico',
      ciudad: 'Mexicali',
      empresa: 'Digimentore',
      area: 'Diseño gráfico',
    },
    {
      idUsuario: 'osakjdiajsdi2839dj3123',
      nombre: 'Dana',
      apellido: 'Nuñez',
      correo: 'dana@correo.com',
      contrasena: 'user123',
      celular: '0998270584',
      foto: 'dana.jpg',
      estado: 1,
      pais: 'Mexico',
      ciudad: 'Mexicali',
      empresa: 'Digimentore',
      area: 'Diseño gráfico',
    },
    {
      idUsuario: 'osakjdiajsdi2839dj323',
      nombre: 'Dana',
      apellido: 'Nuñez',
      correo: 'dana@correo.com',
      contrasena: 'user123',
      celular: '0998270584',
      foto: 'dana.jpg',
      estado: 1,
      pais: 'Mexico',
      ciudad: 'Mexicali',
      empresa: 'Digimentore',
      area: 'Diseño gráfico',
    },
  ];
  ngOnInit(): void {}
}
