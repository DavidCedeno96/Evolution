import {
  Component,
  OnInit,
  Renderer2,
  ElementRef,
  AfterViewInit,
  isDevMode,
} from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { JwtHelperService } from '@auth0/angular-jwt';
import { Usuario } from 'src/app/Models/Usuario';
import { StorageMap } from '@ngx-pwa/local-storage'; // Importa LocalStorage
import {
  AlertError,
  GetImage,
  Loading,
  MsgError,
  MsgErrorConexion,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { UsuarioService } from 'src/app/services/usuario.service';
import { Router } from '@angular/router';
import { ConfiguracionService } from 'src/app/services/configuracion.service';
import { Configuracion } from 'src/app/Models/Configuracion';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent implements OnInit, AfterViewInit {
  loading = Loading();
  alertError = AlertError();
  getImage = GetImage();

  helper = new JwtHelperService();

  verPassword: boolean = false;
  verErrorsInputs: boolean = false;
  numClicksLogin: number = 0;

  formulario!: FormGroup;
  usuario: Usuario = {
    idUsuario: '',
    nombre: '',
    apellido: '',
    correo: '',
    id: '',
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
    puntos: 0,
    creditos: 0,
    estado: 0,
  };

  constructor(
    private renderer: Renderer2,
    private el: ElementRef,
    private formBuilder: FormBuilder,
    private router: Router,
    private localStorage: StorageMap,
    private usuarioServicio: UsuarioService,
    private configuracionService: ConfiguracionService
  ) {
    this.formulario = this.formBuilder.group({
      correo: [
        this.usuario.correo,
        [Validators.required, Validators.maxLength(60), Validators.email],
      ],
      contrasena: [
        this.usuario.contrasena,
        [Validators.required, Validators.maxLength(90)],
      ],
      recuerdame: [false],
    });
  }

  ngOnInit(): void {
    this.loading(true, false);
    this.getRemember();
    this.usuarioServicio.removeLocalItems();

    this.cargarConfig();
  }

  ngAfterViewInit(): void {
    if (!isDevMode()) {
      console.clear();
    }
    const url = window.location;
    console.log(url.origin);
  }

  iniciarSesion() {
    /* console.log(this.formulario.valid);
    console.log(this.formulario.value); */

    this.numClicksLogin += 1;
    if (this.formulario.valid) {
      this.verErrorsInputs = false;
      this.usuario = this.formulario.value;
      //console.log('LOGENADO...');
      this.loading(true, false);
      this.getToken();
    } else {
      this.verErrorsInputs = true;
    }
  }

  getToken() {
    this.usuarioServicio.loginUsuario(this.usuario).subscribe({
      next: (data: any) => {
        const { info, error } = data.response;
        if (error === 0) {
          localStorage.setItem('token', info);
          this.setRemember();
          this.usuarioServicio.startWatching();
          this.router.navigate(['/home']);

          /*const decodeToken = this.helper.decodeToken(info);
          let { role } = decodeToken;
          //Ruta para el jugador
          if (role === 'jug') {
            this.router.navigate(['/homeUser']);
          }
          //Ruta para el administrador
          if (role === 'adm' || role === 'sadm') {
            this.router.navigate(['/homeAdmin']);
          } */
        } else {
          this.alertError(
            'Error de credenciales',
            'Correo o Contraseña incorrectos!'
          );
        }
        this.loading(false, false);
      },
      error: (e) => {
        console.log(e);
        this.loading(false, false);
        this.alertError(TitleError, MsgError);
      },
    });
  }

  cargarConfig() {
    this.configuracionService.getList().subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          let imagenes: Configuracion[] = lista.filter(
            (item: Configuracion) => {
              return item.tipo === 'imagen';
            }
          );
          const fondo = this.el.nativeElement.querySelector('.fondoImagen');
          if (fondo) {
            this.renderer.setStyle(
              fondo,
              'background-image',
              `url("${this.getImage(
                imagenes[0].valor,
                'config',
                'default-login.png'
              )}")`
            );
          }
        } else {
          this.alertError(TitleErrorForm, info);
        }
        this.loading(false, false);
      },
      error: (e) => {
        console.error(e);
        this.alertError(TitleError, MsgErrorConexion);
      },
    });
  }

  setRemember() {
    if (this.formulario.get(['recuerdame'])?.value) {
      this.localStorage.set('user', this.usuario.correo).subscribe(() => {});
      this.localStorage
        .set('contrasena', this.usuario.contrasena)
        .subscribe(() => {});
    } else {
      this.localStorage.set('user', '').subscribe(() => {});
      this.localStorage.set('contrasena', '').subscribe(() => {});
    }
  }

  getRemember() {
    this.localStorage.get('user').subscribe((correo) => {
      if (typeof correo == 'string') {
        this.usuario.correo = correo;
        this.formulario.patchValue({
          correo: correo,
        });
      }
    });

    this.localStorage.get('contrasena').subscribe((contrasena) => {
      if (typeof contrasena == 'string') {
        this.usuario.contrasena = contrasena;
        if (contrasena !== '') {
          this.formulario.patchValue({
            contrasena: contrasena,
            recuerdame: true,
          });
        }
      }
    });
  }

  togglePassword() {
    this.verPassword = !this.verPassword;
  }
}
