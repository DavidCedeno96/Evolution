import { AfterViewInit, Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { Usuario } from 'src/app/Models/Usuario';
import {
  AlertError,
  ChangeRoute,
  GetImage,
  Loading,
  MsgOk,
  SetUpsert,
  Upsert,
  UpsertMsg,
} from 'src/app/Utils/Constants';
import { ContrasenaInvalid } from 'src/app/Utils/RegularExpressions';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-profile-user',
  templateUrl: './profile-user.component.html',
  styleUrls: ['./profile-user.component.css'],
  providers: [MessageService],
})
export class ProfileUserComponent implements OnInit, AfterViewInit {
  getImage = GetImage();
  alertError = AlertError();
  loading = Loading();
  contrasenaInvalid = ContrasenaInvalid();
  setUpsert = SetUpsert();
  changeRoute = ChangeRoute();

  id: string = '';

  campo: string = '';
  error: number = 0;
  info: string = '';

  usuario: Usuario = {
    idUsuario: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: '',
    apellido: '',
    correo: '',
    id: '',
    celular: '',
    foto: '',
    idRol: '',
    rol: '',
    idPais: '',
    pais: '',
    idCiudad: '',
    ciudad: '',
    idEmpresa: '',
    empresa: '',
    idArea: '',
    area: '',
    contrasena: '',
    puntos: 0,
    creditos: 0,
    estado: 0,
  };

  constructor(
    private messageService: MessageService,
    private router: Router,
    private usuarioServicio: UsuarioService
  ) {}

  ngOnInit(): void {
    this.loading(true, false);
    this.id = this.usuarioServicio.getIdUsuario();
  }

  ngAfterViewInit(): void {
    this.loading(true, false);
    this.cargarData(this.id);

    if (Upsert) {
      setTimeout(() => {
        this.messageService.add({
          severity: 'success',
          summary: MsgOk,
          detail: UpsertMsg,
        });
        this.setUpsert(false, '');
      }, 100);
    }
  }

  cargarData(idUsuario: string) {
    this.usuarioServicio.getItem(-1, idUsuario).subscribe({
      next: (data: any) => {
        let { error, usuario } = data.response;
        if (error === 0) {
          this.usuario = usuario;
        } else {
          history.back();
        }
        this.loading(false, false);
      },
      error: (e) => {
        console.error(e);
        if (e.status === 401 || e.status === 403) {
          this.router.navigate(['/']);
        } else {
          history.back();
        }
      },
    });
  }
}
