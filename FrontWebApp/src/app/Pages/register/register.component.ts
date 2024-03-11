import { Component, OnInit, AfterViewInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Area, Ciudad, Empresa, Pais } from 'src/app/Models/Adicional';
import { Usuario } from 'src/app/Models/Usuario';
import {
  AlertError,
  ImgSizeMax,
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
  loading = Loading();
  contrasenaInvalid = ContrasenaInvalid();
  sugerenciaImagen = SugerenciaImagen;

  verPassword: boolean = false;
  verErrorsInputs: boolean = false;
  numClicksSave: number = 0;

  formulario!: FormGroup;
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
      codigoRegistro: [
        '',
        [
          Validators.required,
          Validators.maxLength(50),
          Validators.pattern(exp_invalidos),
        ],
      ],

      idPais: [this.usuario.idPais],
      idCiudad: [this.usuario.idCiudad],
      idEmpresa: [this.usuario.idEmpresa],
      idArea: [this.usuario.idArea],
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
          this.cargarAdicionales();
        } else {
          this.alertError(TitleErrorForm, info); //MsgErrorForm
        }
        this.loading(false, false);
      },
      error: (e) => {
        console.error(e);
        this.router.navigate(['/']);
        this.loading(false, false);
        this.alertError(TitleError, MsgError);
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
        this.router.navigate(['/']);
        this.loading(false, false);
        this.alertError(TitleError, MsgError);
      },
    });
  }

  register() {
    /* console.log(this.formulario.valid);
    console.log(this.formulario.value); */

    this.numClicksSave += 1;
    if (this.formulario.valid) {
      this.loading(true, false);
      this.verErrorsInputs = false;
      this.usuarioServicio.register(this.getFormData()).subscribe({
        next: (data: any) => {
          let { campo, error, info } = data.response;
          if (error === 0) {
            this.router.navigate(['/']);
          } else if (campo) {
            this.error = error;
            this.campo = campo;
            this.info = info;
            this.alertError(TitleErrorForm, MsgErrorForm);
          } else {
            this.alertError(TitleErrorForm, info);
          }
          this.loading(false, false);
        },
        error: (e) => {
          console.error(e);
          this.router.navigate(['/']);
          this.loading(false, false);
          this.alertError(TitleError, MsgError);
        },
      });
    } else {
      this.verErrorsInputs = true;
      this.alertError(TitleErrorForm, MsgErrorForm);
    }
  }

  getFormData(): FormData {
    let formData = new FormData();
    formData.append('nombre', this.usuario.nombre.trim());
    formData.append('apellido', this.usuario.apellido.trim());
    formData.append('correo', this.usuario.correo.trim());
    formData.append('id', this.usuario.id.trim());
    formData.append('celular', this.usuario.celular.trim());
    formData.append('idRol', 'jug');
    formData.append(
      'codigoRegistro',
      this.formulario.get(['codigoRegistro'])?.value
    );
    formData.append('idCiudad', this.usuario.idCiudad);
    formData.append('idArea', this.usuario.idArea);
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

    if (this.selectedFoto.size > ImgSizeMax) {
      this.errorArchivo = true;
    } else {
      this.errorArchivo = false;
    }

    if (this.selectedFoto.size > 0) {
      let reader = new FileReader();
      reader.onload = (e: any) => {
        this.previewFoto = e.target.result;
      };
      reader.readAsDataURL(this.selectedFoto);
    }
    console.log(this.selectedFoto.name, this.previewFoto);
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
