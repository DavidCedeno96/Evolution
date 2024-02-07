import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { Usuario } from 'src/app/Models/Usuario';
import {
  AlertError,
  ChangeRoute,
  GetImage,
  Loading,
  MsgError,
  SinRegistros,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-view-user',
  templateUrl: './view-user.component.html',
  styleUrls: ['./view-user.component.css'],
})
export class ViewUserComponent implements OnInit {
  alertError = AlertError();
  loading = Loading();
  changeRoute = ChangeRoute();
  getImage = GetImage();

  info: string = '';

  formulario!: FormGroup;
  auxUsuarios: Usuario[] = [];
  usuarios: Usuario[] = [
    {
      idUsuario: '',
      nombre: '',
      apellido: '',
      correo: '',
      celular: '',
      foto: '',
      idRol: '',
      rol: '',
      idPais: '',
      idCiudad: '',
      ciudad: '',
      idEmpresa: '',
      empresa: '',
      idArea: '',
      area: '',
      contrasena: '',
      estado: 0,
    },
  ];

  constructor(
    private usuarioServicio: UsuarioService,
    private router: Router,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      buscar: [''],
    });
  }

  ngOnInit(): void {
    this.loading(true, false);
    this.cargarData();
  }

  cargarData() {
    this.usuarioServicio.getList(-1).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.usuarios = lista;
          this.auxUsuarios = lista;
          this.info = SinRegistros;
        } else {
          this.alertError(TitleErrorForm, info);
        }
        this.loading(false, false);
      },
      error: (e) => {
        console.error(e);
        if (e.status === 401 || e.status === 403) {
          this.router.navigate(['/']);
        } else {
          this.alertError(TitleError, MsgError);
          this.loading(false, false);
        }
      },
    });
  }

  submitBuscar() {
    let buscar = this.formulario.get(['buscar'])?.value;
    if (buscar.trim() !== '') {
      this.loading(true, false);
      this.getBuscar(buscar);
    } else {
      this.usuarios = this.auxUsuarios;
    }
  }

  getBuscar(texto: string) {
    this.usuarioServicio.getBuscarList(texto).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.usuarios = lista;
        } else {
          this.usuarios = [];
          this.info = info;
        }
        this.loading(false, false);
      },
      error: (e) => {
        console.error(e);
        if (e.status === 401 || e.status === 403) {
          this.router.navigate(['/']);
        } else {
          this.alertError(TitleError, MsgError);
        }
      },
    });
  }

  eliminar(idUsuario: string) {
    console.log('Eliminando!', idUsuario);
  }

  defaultList(event: Event) {
    let text = (event.target as HTMLInputElement).value;
    if (!text) {
      this.usuarios = this.auxUsuarios;
    }
  }
}
