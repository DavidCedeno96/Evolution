import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Area, Ciudad, Empresa, Pais } from 'src/app/Models/Adicional';
import { Usuario } from 'src/app/Models/Usuario';
import {
  AlertError,
  GetImage,
  ImgSizeMax,
  Loading,
  MsgErrorForm,
  SetUpsert,
  TitleErrorForm,
  SugerenciaImagen,
  ImgWidthMax,
  ImgHeightMax,
  HtmlLicencias,
  ChangeRoute,
} from 'src/app/Utils/Constants';
import {
  ContrasenaInvalid,
  exp_invalidos,
  exp_numeros,
  exp_palabras,
} from 'src/app/Utils/RegularExpressions';
import { AdicionalService } from 'src/app/services/adicional.service';
import { UsuarioService } from 'src/app/services/usuario.service';
import * as intlTelInput from 'intl-tel-input';

@Component({
  selector: 'app-upsert-user',
  templateUrl: './upsert-user.component.html',
  styleUrls: ['./upsert-user.component.css'],
})
export class UpsertUserComponent implements OnInit, AfterViewInit {
  getImage = GetImage();
  alertError = AlertError();
  loading = Loading();
  contrasenaInvalid = ContrasenaInvalid();
  setUpsert = SetUpsert();
  changeRoute = ChangeRoute();
  sugerenciaImagen = SugerenciaImagen;

  type: string = '';
  titulo: string = '';

  verPassword: boolean = false;
  verErrorsInputs: boolean = false;
  numClicksSave: number = 0;

  selectedFoto!: File;
  previewFoto: string = '';
  errorArchivo: boolean = false;
  id: string = '';
  campo: string = '';
  error: number = 0;
  info: string = '';

  formulario!: FormGroup;
  usuario: Usuario = {
    idUsuario: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: '',
    apellido: '',
    correo: '',
    id: '',
    paisCode: '',
    paisIso2: 'ec',
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

  pais: Pais[] = [];
  ciudad: Ciudad[] = [];
  auxCiudad: Ciudad[] = [];
  empresa: Empresa[] = [];
  area: Area[] = [];
  auxArea: Area[] = [];

  iti: any;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private usuarioServicio: UsuarioService,
    private adicionalServicio: AdicionalService,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      idUsuario: [this.usuario.idUsuario],
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
          Validators.minLength(9),
          Validators.pattern(exp_numeros),
        ],
      ],

      foto: [this.usuario.foto],
      idRol: [this.usuario.idRol, [Validators.required]],

      idPais: [this.usuario.idPais],
      idCiudad: [this.usuario.idCiudad],
      idEmpresa: [this.usuario.idEmpresa],
      idArea: [this.usuario.idArea],
    });
  }

  ngOnInit(): void {
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    if (this.type === 'editar') {
      this.loading(true, false);
      this.cargarData(this.id);
    } else {
      this.setInputCodesPhone();
    }
  }

  getRouteParams() {
    this.route.queryParams.subscribe((params) => {
      this.type = params['type'];
      let idUsuario = params['usuario'];
      if (idUsuario === '' && this.type === 'editar') {
        this.changeRoute('/404', {});
      }
      switch (this.type) {
        case 'crear': {
          this.titulo = 'nuevo usuario';
          break;
        }
        case 'editar': {
          this.id = idUsuario;
          this.titulo = 'editar usuario';
          break;
        }
        default: {
          this.changeRoute('/404', {});
          break;
        }
      }
    });
    this.cargarAdicionales();
  }

  cargarData(idUsuario: string) {
    this.usuarioServicio.getItem(-1, idUsuario).subscribe({
      next: (data: any) => {
        let { error, usuario } = data.response;
        if (error === 0) {
          this.usuario = usuario;
          this.formulario.patchValue(usuario);

          this.setInputCodesPhone();
          this.auxCiudad = this.ciudadList(usuario.idPais);
          this.auxArea = this.areaList(usuario.idEmpresa);
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

  upsert() {
    this.numClicksSave += 1;
    if (this.formulario.valid && !this.errorArchivo) {
      this.verErrorsInputs = false;
      this.usuario = this.formulario.value;

      this.loading(true, false);
      switch (this.type) {
        case 'crear': {
          this.create();
          break;
        }
        case 'editar': {
          this.update();
          break;
        }
        default: {
          this.changeRoute('/404', {});
          break;
        }
      }
    } else {
      this.verErrorsInputs = true;

      this.alertError(TitleErrorForm, MsgErrorForm);
    }
  }

  create() {
    this.usuarioServicio.create(this.getFormData()).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.setUpsert(true, 'Registro Creado');
          this.router.navigate(['/view-user']);
        } else if (error === 2) {
          this.alertError(TitleErrorForm, info + HtmlLicencias);
        } else if (campo !== '') {
          this.error = error;
          this.campo = campo;
          this.info = info;
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

  update() {
    this.usuarioServicio.update(this.getFormData()).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.setUpsert(true, 'Registro Actualizado');
          this.router.navigate(['/view-user']);
        } else if (campo !== '') {
          this.error = error;
          this.campo = campo;
          this.info = info;
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

  getFormData(): FormData {
    let formData = new FormData();
    formData.append('idUsuario', this.usuario.idUsuario);
    formData.append('nombre', this.usuario.nombre.trim());
    formData.append('apellido', this.usuario.apellido.trim());
    formData.append('correo', this.usuario.correo.trim());
    formData.append('id', this.usuario.id.trim());
    formData.append('paisCode', this.iti.selectedCountryData.dialCode);
    formData.append('paisIso2', this.iti.defaultCountry);
    formData.append('celular', this.usuario.celular.trim());
    formData.append('idRol', this.usuario.idRol);
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
    } else {
      this.errorArchivo = false;
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

  setInputCodesPhone() {
    let phoneCode = document.getElementById('phone-code');
    if (phoneCode) {
      this.iti = intlTelInput(phoneCode, {
        initialCountry: this.usuario.paisIso2,
        preferredCountries: ['us', 'ec'],
        separateDialCode: true,
        //utilsScript: 'https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/23.1.0/js/utils.js', // Necesario para algunas funcionalidades de formato y validación
        //utilsScript: 'assets/utils.js',
      });
    }
  }
}
