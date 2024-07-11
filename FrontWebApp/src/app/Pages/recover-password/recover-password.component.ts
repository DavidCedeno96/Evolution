import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Usuario } from 'src/app/Models/Usuario';
import { UsuarioService } from 'src/app/services/usuario.service';
import {
  AlertError,
  AlertSuccess,
  ChangeRoute,
  Loading,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { ContrasenaInvalid } from 'src/app/Utils/RegularExpressions';

@Component({
  selector: 'app-recover-password',
  templateUrl: './recover-password.component.html',
  styleUrls: ['./recover-password.component.css'],
})
export class RecoverPasswordComponent implements OnInit, AfterViewInit {
  loading = Loading();
  contrasenaInvalid = ContrasenaInvalid();
  alertError = AlertError();
  alertSuccess = AlertSuccess();
  changeRoute = ChangeRoute();

  seeUserPassPanel: boolean = false;
  errorPass: boolean = false;
  userToken: string = '';

  verErrorsInputs: boolean = false;
  formulario!: FormGroup;

  correoEnviado: boolean = false;

  usuario: Usuario = {
    idUsuario: '',
    nombre: '',
    apellido: '',
    correo: '',
    id: '',
    paisCode: '',
    paisIso2: '',
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
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private usuarioServicio: UsuarioService,
    private router: Router
  ) {
    this.formulario = this.formBuilder.group({
      correo: [
        '',
        [Validators.required, Validators.maxLength(60), Validators.email],
      ],
      contrasena: ['', [Validators.required, this.contrasenaInvalid]],
      contrasena2: ['', [Validators.required]],
    });
  }

  ngOnInit(): void {
    this.loading(true, false);
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    this.cargarView();
  }

  getRouteParams() {
    this.route.queryParams.subscribe((params) => {
      this.userToken = params['user'];
      if (this.userToken === '' || !params['user']) {
        this.seeUserPassPanel = false;
        this.formulario.patchValue({
          contrasena: 'Prueba.123',
          contrasena2: 'Prueba.123',
        });
      } else {
        this.seeUserPassPanel = true;
        this.formulario.patchValue({
          correo: 'myuser@prueba.com',
        });
      }
    });
  }

  cargarView() {
    this.usuarioServicio.registerView().subscribe({
      next: (data: any) => {
        let { info, error } = data.response;
        if (error === 0) {
          localStorage.setItem('token', info);
          this.usuarioServicio.startWatching();
        } else {
          this.router.navigate(['/login']);
          this.alertError(TitleErrorForm, info); //MsgErrorForm
        }
        this.loading(false, false);
      },
      error: (e) => {
        console.error(e);
        if (e.status === 401 || e.status === 403) {
          this.router.navigate(['/']);
        } else {
          this.changeRoute('/404', {});
        }
      },
    });
  }

  submit() {
    /* console.log(this.formulario.valid);
    console.log(this.formulario.value); */

    if (this.formulario.valid) {
      this.verErrorsInputs = false;
      if (this.seeUserPassPanel) {
        let pass1 = this.formulario.get(['contrasena'])?.value;
        let pass2 = this.formulario.get(['contrasena2'])?.value;

        if (pass1 === pass2) {
          this.usuario = this.formulario.value;
          this.loading(true, false);
          this.errorPass = false;
          this.verErrorsInputs = false;
          this.cambiarContraseña();
        } else {
          this.errorPass = true;
          this.verErrorsInputs = true;
        }
      } else {
        this.loading(true, false);
        this.usuario = this.formulario.value;
        this.enviarCorreo();
      }
    } else {
      this.verErrorsInputs = true;
    }
  }

  validPass() {
    let pass1 = this.formulario.get(['contrasena'])?.value;
    let pass2 = this.formulario.get(['contrasena2'])?.value;

    if (this.formulario.valid && this.verErrorsInputs && pass1 && pass2) {
      if (pass1 === pass2) {
        this.errorPass = false;
      } else {
        this.errorPass = true;
      }
    } else {
      this.errorPass = false;
    }
  }

  enviarCorreo() {
    setTimeout(() => {
      this.usuarioServicio
        .cambiarPassEnviarCorreo(this.getFormData())
        .subscribe({
          next: (data: any) => {
            let { error, info } = data.response;
            if (error === 0) {
              this.correoEnviado = true;
            } else {
              this.correoEnviado = false;
              this.alertError(TitleErrorForm, info);
            }
            this.loading(false, false);
          },
          error: () => {
            this.changeRoute('/404', {});
          },
        });
    }, 500);
  }

  cambiarContraseña() {
    setTimeout(() => {
      this.usuarioServicio
        .cambiarPass(this.userToken, this.getFormData())
        .subscribe({
          next: (data: any) => {
            let { error, info } = data.response;
            if (error === 0) {
              this.alertSuccess(
                'Contraseña Actualizada',
                `<div>
                  <h6>
                    La contraseña fue actualizada satisfactoriamente
                  </h6>                                    
                </div>`
              );
            } else {
              this.alertError(TitleErrorForm, info);
            }
            this.router.navigate(['/']);
            this.loading(false, false);
          },
          error: () => {
            this.alertError(
              'Enlace Expirado',
              `<div>
                <h6>
                  El enlace para cambiar la contraseña ha expirado
                </h6>
              </div>`
            );
            this.router.navigate(['/']);
          },
        });
    }, 3000);
  }

  getFormData(): FormData {
    let formData = new FormData();
    const url = window.location;

    formData.append('correo', this.usuario.correo.trim());
    formData.append(
      'urlVistaCambiarPass',
      `${url.origin}/recover-password?user=`
    );
    formData.append('clave', this.usuario.contrasena.trim());

    return formData;
  }
}
