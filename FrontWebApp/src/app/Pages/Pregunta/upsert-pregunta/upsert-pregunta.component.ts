import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Opcion, PreguntaOpciones } from 'src/app/Models/Pregunta';
import {
  AlertError,
  ChangeRoute,
  Loading,
  MsgError,
  MsgErrorForm,
  SetUpsert,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { exp_invalidos } from 'src/app/Utils/RegularExpressions';
import { PreguntaService } from 'src/app/services/pregunta.service';

@Component({
  selector: 'app-upsert-pregunta',
  templateUrl: './upsert-pregunta.component.html',
  styleUrls: ['./upsert-pregunta.component.css'],
})
export class UpsertPreguntaComponent implements OnInit, AfterViewInit {
  alertError = AlertError();
  changeRoute = ChangeRoute();
  loading = Loading();
  setUpsert = SetUpsert();

  auxIdPregunta: string = '';
  auxOpcionList: Opcion[] = [];
  opcion: string[] = ['A', 'B', 'C', 'D'];

  numClicksSave: number = 0;

  type: string = '';
  titulo: string = '';

  verErrorsInputs: boolean = false;

  idReto: string = '';
  id: string = '';
  campo: string = '';
  error: number = 0;
  info: string = '';

  formulario!: FormGroup;
  preguntaOpciones: PreguntaOpciones = {
    pregunta: {
      idPregunta: '7c8c2672-2233-486a-a184-f0b51eb4a331',
      idReto: '7c8c2672-2233-486a-a184-f0b51eb4a331',
      nombre: '',
    },
    opcionList: [],
  };

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private preguntaServicio: PreguntaService,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      pregunta: [
        this.preguntaOpciones.pregunta.nombre,
        [
          Validators.required,
          Validators.maxLength(200),
          Validators.pattern(exp_invalidos),
        ],
      ],
      totalOpciones: ['', [Validators.required]],
    });
  }

  ngOnInit(): void {
    this.getRouteParams();
  }

  ngAfterViewInit(): void {}

  getRouteParams() {
    this.route.queryParams.subscribe((params) => {
      this.type = params['type'];
      let idPregunta = params['pregunta'];
      this.idReto = params['reto'];
      if (idPregunta === '' && this.idReto === '' && this.type === 'editar') {
        history.back();
      }
      switch (this.type) {
        case 'crear': {
          this.titulo = 'nueva pregunta';
          this.cargaOpciones(0, this.preguntaOpciones);
          break;
        }
        case 'editar': {
          this.id = idPregunta;
          this.titulo = 'editar pregunta';
          this.loading(true, false);
          this.cargarPregunta(idPregunta);
          break;
        }
        default: {
          this.titulo = '';
          history.back();
          break;
        }
      }
    });
  }

  cargarPregunta(idPregunta: string) {
    this.preguntaServicio.getItem(-1, idPregunta).subscribe({
      next: (data: any) => {
        let { error, pregunta, opcionList } = data.response;
        if (error === 0) {
          this.preguntaOpciones = data.response;
          this.auxOpcionList = opcionList;

          let totalOpciones = opcionList.length;
          this.cargaOpciones(totalOpciones, data.response);
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

  cargaOpciones(totalOpciones: number, preguntaOpciones: PreguntaOpciones) {
    if (totalOpciones > 1 && totalOpciones < 5) {
      this.formulario.patchValue({
        pregunta: preguntaOpciones.pregunta.nombre,
        totalOpciones: totalOpciones,
      });

      this.preguntaOpciones.opcionList = this.opcionItem(totalOpciones);
    } else {
      this.preguntaOpciones.opcionList = [];
    }
  }

  upsert() {
    /* console.log(this.formulario.valid);
    console.log(this.formulario.value); */

    this.numClicksSave += 1;
    if (this.formulario.valid) {
      this.verErrorsInputs = false;
      this.setData();
      //console.log('GUARDANDO ......', this.preguntaOpciones);

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
          this.loading(false, false);
          history.back();
          break;
        }
      }
    } else {
      this.verErrorsInputs = true;

      this.alertError(TitleErrorForm, MsgErrorForm);
    }
  }

  create() {
    this.preguntaServicio.create(this.preguntaOpciones).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.setUpsert(true, 'Registro Creado');
          this.changeRoute('/view-pregunta', { reto: this.idReto });
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
          this.alertError(TitleError, MsgError);
          this.loading(false, false);
        }
      },
    });
  }

  update() {
    this.preguntaServicio.update(this.preguntaOpciones).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.setUpsert(true, 'Registro Actualizado');
          this.changeRoute('/view-pregunta', { reto: this.idReto });
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
          this.alertError(TitleError, MsgError);
          this.loading(false, false);
        }
      },
    });
  }

  setData() {
    this.preguntaOpciones.pregunta.nombre = this.formulario.get([
      'pregunta',
    ])?.value;
    let numOpciones: number = this.formulario.get(['totalOpciones'])?.value;
    let opCorrecta: string = this.formulario.get(['opcionCorrecta'])?.value;

    for (let i = 0; i < numOpciones; i++) {
      let opcion: Opcion = {
        idOpcion: '7c8c2672-2233-486a-a184-f0b51eb4a331',
        idPregunta: '7c8c2672-2233-486a-a184-f0b51eb4a331',
        nombre: '',
        correcta: 0,
      };
      opcion.nombre = this.formulario.get(['opcion' + this.opcion[i]])?.value;

      if (this.opcion[i] === opCorrecta) {
        opcion.correcta = 1;
      }
      //debugger;
      if (this.type === 'editar') {
        opcion.idOpcion = this.auxOpcionList[i].idOpcion;
        opcion.idPregunta = this.id;
      } else {
        this.preguntaOpciones.pregunta.idReto = this.idReto;
      }

      this.preguntaOpciones.opcionList[i] = opcion;
    }
  }

  selectTotalOpciones(event: Event) {
    const selectedValue = (event.target as HTMLSelectElement).value;
    if (Number(selectedValue) < 5) {
      this.preguntaOpciones.opcionList = this.opcionItem(Number(selectedValue));
      this.auxOpcionList = this.opcionItem(Number(selectedValue));
    } else {
      this.preguntaOpciones.opcionList = [];
      this.auxOpcionList = [];
    }
  }

  opcionItem(num: number): Opcion[] {
    var item = [];
    this.eliminarControlform('opcion');
    for (let i = 0; i < num; i++) {
      item.push({
        idOpcion: '7c8c2672-2233-486a-a184-f0b51eb4a331',
        idPregunta: this.auxIdPregunta,
        nombre: '',
        correcta: 0,
      });
      if (this.auxOpcionList.length > 0 && i < this.auxOpcionList.length) {
        item[i] = this.auxOpcionList[i];
        this.agregarControlform(
          i,
          this.auxOpcionList[i].nombre,
          this.getOpLetraByIndex()
        );
      } else {
        this.agregarControlform(i, '', '');
      }
    }
    return item;
  }

  agregarControlform(index: number, value: string, opCorrecta: string) {
    this.formulario.addControl(
      `opcion${this.opcion[index]}`,
      this.formBuilder.control(value, [
        Validators.required,
        Validators.maxLength(200),
        Validators.pattern(exp_invalidos),
      ])
    );

    this.formulario.addControl(
      `opcionCorrecta`,
      this.formBuilder.control(opCorrecta, [Validators.required])
    );
  }

  eliminarControlform(termino: string) {
    Object.keys(this.formulario.controls).forEach((controlName) => {
      if (controlName.includes(termino)) {
        this.formulario.removeControl(controlName);
      }
    });
  }

  getOpLetraByIndex(): string {
    let letra: string = '';
    for (let i = 0; i < this.auxOpcionList.length; i++) {
      if (this.auxOpcionList[i].correcta === 1) {
        letra = this.opcion[i];
      }
    }
    return letra;
  }
}
