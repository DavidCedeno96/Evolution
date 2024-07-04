import { Component, OnInit, AfterViewInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Area, Ciudad, Empresa, Pais } from 'src/app/Models/Adicional';
import { Usuario } from 'src/app/Models/Usuario';
import {
  AlertError,
  AlertSuccess,
  ChangeRoute,
  ImgHeightMax,
  ImgSizeMax,
  ImgWidthMax,
  Loading,
  MsgError,
  MsgErrorForm,
  SugerenciaImagen,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import {
  ContrasenaInvalid,
  exp_invalidos,
  exp_numeros,
  exp_palabras,
} from 'src/app/Utils/RegularExpressions';
import { AdicionalService } from 'src/app/services/adicional.service';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css'],
})
export class RegisterComponent implements OnInit, AfterViewInit {
  alertError = AlertError();
  alertSuccess = AlertSuccess();
  loading = Loading();
  changeRoute = ChangeRoute();
  contrasenaInvalid = ContrasenaInvalid();
  sugerenciaImagen = SugerenciaImagen;

  modalCodigo: boolean = false;

  verPassword: boolean = false;
  verErrorsInputs: boolean = false;
  numClicksSave: number = 0;

  formulario!: FormGroup;
  frmCodigo!: FormGroup;

  selectedFoto!: File;
  previewFoto: string = '';
  errorArchivo: boolean = false;

  campo: string = '';
  error: number = 0;
  info: string = '';

  pais: Pais[] = [];
  ciudad: Ciudad[] = [];
  auxCiudad: Ciudad[] = [];
  empresa: Empresa[] = [];
  area: Area[] = [];
  auxArea: Area[] = [];

  usuario: Usuario = {
    idUsuario: '7c8c2672-2233-486a-a184-f0b51eb4a331',
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
    private adicionalServicio: AdicionalService,
    private usuarioServicio: UsuarioService,
    private router: Router,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      nombre: [
        this.usuario.nombre,
        [
          Validators.required,
          Validators.maxLength(23),
          Validators.pattern(exp_palabras),
        ],
      ],
      apellido: [
        this.usuario.apellido,
        [
          Validators.required,
          Validators.maxLength(23),
          Validators.pattern(exp_palabras),
        ],
      ],
      correo: [
        this.usuario.correo,
        [Validators.required, Validators.maxLength(60), Validators.email],
      ],
      id: [
        this.usuario.id,
        [
          Validators.required,
          Validators.minLength(3),
          Validators.maxLength(20),
          Validators.pattern(exp_invalidos),
        ],
      ],
      contrasena: [
        this.usuario.contrasena,
        [Validators.maxLength(60), this.contrasenaInvalid],
      ],
      celular: [
        this.usuario.celular,
        [
          Validators.maxLength(15),
          Validators.minLength(10),
          Validators.pattern(exp_numeros),
        ],
      ],

      foto: [this.usuario.foto],

      idPais: [this.usuario.idPais],
      idCiudad: [this.usuario.idCiudad],
      idEmpresa: [this.usuario.idEmpresa],
      idArea: [this.usuario.idArea],
    });

    this.frmCodigo = this.formBuilder.group({
      codigoRegistro: [
        '',
        [
          Validators.required,
          Validators.maxLength(50),
          Validators.pattern(exp_invalidos),
        ],
      ],
    });
  }

  ngOnInit(): void {
    this.loading(true, false);
    this.cargarView();
  }

  ngAfterViewInit(): void {}

  cargarView() {
    this.usuarioServicio.registerView().subscribe({
      next: (data: any) => {
        let { info, error } = data.response;
        if (error === 0) {
          localStorage.setItem('token', info);
          this.usuarioServicio.startWatching();
          this.cargarAdicionales();
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

  cargarAdicionales() {
    this.adicionalServicio.getListUsuario(-1).subscribe({
      next: (data: any) => {
        let { paisList, ciudadList, empresaList, areaList } = data.response;
        this.pais = paisList.lista;
        this.ciudad = ciudadList.lista;
        this.empresa = empresaList.lista;
        this.area = areaList.lista;
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

  dialogCodigo() {
    /* console.log(this.formulario.valid);
    console.log(this.formulario.value); */

    this.numClicksSave += 1;
    if (this.formulario.valid) {
      this.usuario = this.formulario.value;
      this.error = 0;
      this.verErrorsInputs = false;
      this.modalCodigo = true;
    } else {
      this.verErrorsInputs = true;
      this.alertError(TitleErrorForm, MsgErrorForm);
    }
  }

  register() {
    if (this.frmCodigo.valid) {
      this.loading(true, false);
      this.verErrorsInputs = false;
      this.usuarioServicio.sedEmail_register(this.getFormData()).subscribe({
        next: (data: any) => {
          let { campo, error, info } = data.response;
          this.error = error;
          this.campo = campo;
          this.info = info;
          if (error === 0) {
            this.modalCodigo = false;
            this.alertSuccess(
              'Correo enviado',
              `<div>
                <h6>
                  Hemos enviado un enlace para activar tu cuenta a tu correo
                  electrónico.
                </h6>
                <span class="d-block">Tiempo de duración del enlace 5 minutos</span>
                <small>Si no recibiste el correo revisa el correo no deseado</small>
              </div>`
            );
            this.router.navigate(['/login']);
          } else if (error === 1) {
            this.modalCodigo = false;
            this.alertError(TitleErrorForm, info);
          } else if (error === 2) {
            this.modalCodigo = false;
            this.alertError(
              TitleErrorForm,
              info +
                '<span style="display: block">Contactate con el Administrador</span>'
            );
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
    } else {
      this.verErrorsInputs = true;
      //this.alertError(TitleErrorForm, MsgErrorForm);
    }
  }

  getFormData(): FormData {
    let formData = new FormData();
    const url = window.location;

    formData.append('nombre', this.usuario.nombre.trim());
    formData.append('apellido', this.usuario.apellido.trim());
    formData.append('correo', this.usuario.correo.trim());
    formData.append('id', this.usuario.id.trim());
    formData.append('idRol', 'jug');
    formData.append(
      'codigoRegistro',
      this.frmCodigo.get(['codigoRegistro'])?.value
    );
    formData.append('urlVistaActivarUsuario', `${url.origin}/login?user=`);
    if (this.usuario.contrasena) {
      formData.append('contrasena', this.usuario.contrasena);
    } else {
      formData.append('contrasena', '');
    }
    if (this.selectedFoto) {
      formData.append('archivo', this.selectedFoto);
    }

    return formData;
  }

  ciudadList(idPais: string): Ciudad[] {
    return this.ciudad.filter((item) => {
      return item.idPais == idPais;
    });
  }

  areaList(idEmpresa: string): Area[] {
    return this.area.filter((item) => {
      return item.idEmpresa == idEmpresa;
    });
  }

  onFileSelected(event: Event) {
    this.selectedFoto = (event.target as HTMLInputElement).files![0];

    if (this.selectedFoto) {
      let reader = new FileReader();
      reader.onload = (e: any) => {
        let img = new Image();
        img.src = e.target.result;
        img.onload = () => {
          let w = (img as HTMLImageElement).width;
          let h = (img as HTMLImageElement).height;

          if (
            this.selectedFoto.size > ImgSizeMax ||
            w > ImgWidthMax ||
            h > ImgHeightMax
          ) {
            this.errorArchivo = true;
          } else {
            this.errorArchivo = false;
          }
        };

        this.previewFoto = img.src;
      };
      reader.readAsDataURL(this.selectedFoto);
    }
  }

  selectedPais(event: Event) {
    const selectedValue = (event.target as HTMLSelectElement).value;
    this.auxCiudad = this.ciudadList(selectedValue);
  }

  selectedEmpresa(event: Event) {
    const selectedValue = (event.target as HTMLSelectElement).value;
    this.auxArea = this.areaList(selectedValue);
  }

  togglePassword() {
    this.verPassword = !this.verPassword;
  }
}
