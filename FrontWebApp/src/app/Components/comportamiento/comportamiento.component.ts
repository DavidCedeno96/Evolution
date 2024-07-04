import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { PreguntaOpciones } from 'src/app/Models/Pregunta';
import { Usuario } from 'src/app/Models/Usuario';
import {
  AlertError,
  ChangeRoute,
  DateCompare,
  GetImage,
  Loading,
  SetUpsert,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { exp_invalidos } from 'src/app/Utils/RegularExpressions';
import { PreguntaService } from 'src/app/services/pregunta.service';
import { RetoService } from 'src/app/services/reto.service';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-comportamiento',
  templateUrl: './comportamiento.component.html',
  styleUrls: ['./comportamiento.component.css'],
})
export class ComportamientoComponent implements OnInit, AfterViewInit {
  load = Loading();
  dateCompare = DateCompare();
  alertError = AlertError();
  changeRoute = ChangeRoute();
  getImage = GetImage();
  setUpsert = SetUpsert();

  idReto: string = '';
  idUsuario: string = '';

  first: number = 0;
  rows: number = 5; // items por página

  modal: boolean = false;
  verErrorsInputs: boolean = false;
  formulario: FormGroup;

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

  preguntaOpciones: PreguntaOpciones[] = [
    {
      pregunta: {
        idPregunta: '',
        idReto: '',
        nombre:
          '¿Cuáles son los tres predadores del reino animal reconocidos por: 1) habilidad de cazar en grupo, 2) camuflajearse para sorprender a su presa, 3) poseer sentidos refinados?',
      },
      opcionList: [
        {
          idOpcion: '',
          idPregunta: '',
          idTipoEntrada: '',
          tipoEntrada: '',
          nombre: '1) Tiburón blanco; 2) elefante; 3) escorpión',
          correcta: 0,
          cantVotos: 0,
          valor: 0,
          cantVotosXvalor: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          idTipoEntrada: '',
          tipoEntrada: '',
          nombre: '1) Leon; 2) elefante; 3) escorpión',
          correcta: 0,
          cantVotos: 0,
          valor: 0,
          cantVotosXvalor: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          idTipoEntrada: '',
          tipoEntrada: '',
          nombre: '1) Hiena; 2) Oso polar; 3) Lobo gris',
          correcta: 0,
          cantVotos: 0,
          valor: 0,
          cantVotosXvalor: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          idTipoEntrada: '',
          tipoEntrada: '',
          nombre: '1) Tigre; 2) águila; 3) gato',
          correcta: 1,
          cantVotos: 0,
          valor: 0,
          cantVotosXvalor: 0,
        },
      ],
    },
  ];

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private preguntaServicio: PreguntaService,
    private retoService: RetoService,
    private usuarioService: UsuarioService,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({});
  }

  ngOnInit(): void {
    this.load(true, false);
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    this.cargarUserData();
  }

  getRouteParams() {
    this.route.queryParams.subscribe((params) => {
      this.idReto = params['reto'];
      this.idUsuario = params['user'];
      if (
        this.idReto === '' ||
        this.idUsuario === '' ||
        !params['reto'] ||
        !params['user']
      ) {
        this.changeRoute('/404', {});
      }
    });
  }

  cargarUserData() {
    this.usuarioService.getItem(-1, this.idUsuario).subscribe({
      next: (data: any) => {
        let { error, usuario } = data.response;
        if (error === 0) {
          this.usuario = usuario;
          this.cargarPreguntas();
        } else {
          history.back();
        }
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

  cargarPreguntas() {
    this.preguntaServicio.getList(-1, this.idReto).subscribe({
      next: (data: any) => {
        let { error, info, list } = data.response;
        if (error === 0) {
          this.preguntaOpciones = list;

          this.preguntaOpciones.forEach((item) => {
            this.agregarControlform(
              item.pregunta.nombre,
              item.pregunta.idPregunta
            );
          });
        } else {
          this.alertError(TitleErrorForm, info);
        }
        this.load(false, false);
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

  finalizarComportamiento() {
    this.load(true, false);

    /* console.log(this.formulario.valid);
    console.log(this.formulario.value); */

    if (this.formulario.valid) {
      this.verErrorsInputs = false;

      this.retoService.createUsuarioxOpciones(this.setData()).subscribe({
        next: (data: any) => {
          let { error, info } = data.response;
          if (error === 0) {
            this.setUpsert(true, 'Usuario Validado');
            this.changeRoute('/validaciones/users', { reto: this.idReto });
          } else {
            this.alertError(TitleErrorForm, info); //MsgErrorForm
          }
          this.load(false, false);
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
      this.modal = true;
      this.load(false, false);
    }
  }

  setData(): FormData {
    let formData = new FormData();

    const idsOpciones = Object.values(this.formulario.value);
    const selectedIdsOptions: string[] = idsOpciones.map((item) =>
      String(item)
    );

    formData.append('idReto', this.idReto);
    formData.append('idUsuario', this.idUsuario);
    formData.append('jsonList', JSON.stringify(selectedIdsOptions));

    return formData;
  }

  agregarControlform(name: string, id: string) {
    this.formulario.addControl(
      `pregunta_|_${name}_|_${id}`,
      this.formBuilder.control('', [
        Validators.required,
        Validators.maxLength(200),
        Validators.pattern(exp_invalidos),
      ])
    );
  }

  getNumberPregunta(idPregunta: string): number {
    let index: number = this.preguntaOpciones.findIndex(
      (item) => item.pregunta.idPregunta === idPregunta
    );
    return index + 1;
  }

  getPreguntasSinContestar(): string[] {
    let list = [];

    if (!this.formulario.valid) {
      for (let item in this.formulario.value) {
        if (this.formulario.value[item] === '') {
          let auxItem = item.split('_|_')[1];
          let id = item.split('_|_')[2];

          let pregunta = `${this.getNumberPregunta(id)}. ${auxItem}`;

          list.push(pregunta);
        }
      }
    }
    return list;
  }

  paginatedItems(): PreguntaOpciones[] {
    const startIndex = this.first;
    const endIndex = startIndex + this.rows;
    return this.preguntaOpciones.slice(startIndex, endIndex);
  }

  totalItems(): number {
    return this.preguntaOpciones.length;
  }

  onPageChange(event: any) {
    this.first = event.first;
    this.rows = event.rows;

    window.scrollTo({ top: 0, behavior: 'smooth' });
  }
}
