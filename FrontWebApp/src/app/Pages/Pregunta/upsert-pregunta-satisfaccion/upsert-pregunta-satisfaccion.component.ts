import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router, UrlSegment } from '@angular/router';
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
import {
  OptionsListComportamiento,
  OptionsListSatisfaccion,
} from 'src/app/Utils/DefaultLists';
import { exp_invalidos, exp_numeros } from 'src/app/Utils/RegularExpressions';
import { PreguntaService } from 'src/app/services/pregunta.service';

@Component({
  selector: 'app-upsert-pregunta-satisfaccion',
  templateUrl: './upsert-pregunta-satisfaccion.component.html',
  styleUrls: ['./upsert-pregunta-satisfaccion.component.css'],
})
export class UpsertPreguntaSatisfaccionComponent
  implements OnInit, AfterViewInit
{
  alertError = AlertError();
  changeRoute = ChangeRoute();
  loading = Loading();
  setUpsert = SetUpsert();

  auxIdPregunta: string = '';
  auxOpcionList: Opcion[] = [];
  opcion: string[] = ['A', 'B', 'C', 'D', 'E'];

  numClicksSave: number = 0;

  type: string = '';
  titulo: string = '';

  verErrorsInputs: boolean = false;

  idReto: string = '';
  id: string = '';
  tipoReto: string = '';

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

  defaultOptions: Opcion[] = [];

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

    this.route.url.subscribe((urlSegments: UrlSegment[]) => {
      this.tipoReto = urlSegments[1].path;
      if (this.tipoReto === 'comportamiento') {
        this.defaultOptions = OptionsListComportamiento;
      } else {
        this.defaultOptions = OptionsListSatisfaccion;
      }
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
        this.changeRoute('/404', {});
      }
      switch (this.type) {
        case 'crear': {
          this.titulo = 'nueva pregunta';
          this.cargaOpciones(5, this.preguntaOpciones);
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
          this.changeRoute('/404', {});
          break;
        }
      }
    });
  }

  cargarPregunta(idPregunta: string) {
    this.preguntaServicio.getItem(-1, idPregunta).subscribe({
      next: (data: any) => {
        let { error, opcionList } = data.response;
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
          this.changeRoute('/404', {});
        }
      },
    });
  }

  cargaOpciones(totalOpciones: number, preguntaOpciones: PreguntaOpciones) {
    if (totalOpciones > 1 && totalOpciones < 6) {
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
          this.changeRoute('/404', {});
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
          this.changeRoute('/404', {});
        }
      },
    });
  }

  setData() {
    this.preguntaOpciones.pregunta.nombre = this.formulario.get([
      'pregunta',
    ])?.value;
    let numOpciones: number = this.formulario.get(['totalOpciones'])?.value;

    for (let i = 0; i < numOpciones; i++) {
      let opcion: Opcion = {
        idOpcion: '7c8c2672-2233-486a-a184-f0b51eb4a331',
        idPregunta: '7c8c2672-2233-486a-a184-f0b51eb4a331',
        idTipoEntrada: '7c8c2672-2233-486a-a184-f0b51eb4a331',
        tipoEntrada: '',
        nombre: '',
        correcta: 0,
        cantVotos: 0,
        valor: 0,
        cantVotosXvalor: 0,
      };
      opcion.nombre = this.formulario.get(['opcion' + this.opcion[i]])?.value;
      opcion.valor = this.formulario.get(['valor' + this.opcion[i]])?.value;

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
    if (Number(selectedValue) < 6) {
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
    this.eliminarControlform('valor');
    for (let i = 0; i < num; i++) {
      item.push({
        idOpcion: '7c8c2672-2233-486a-a184-f0b51eb4a331',
        idPregunta: this.auxIdPregunta,
        idTipoEntrada: '7c8c2672-2233-486a-a184-f0b51eb4a331',
        tipoEntrada: '',
        nombre: '',
        correcta: 0,
        cantVotos: 0,
        valor: 0,
        cantVotosXvalor: 0,
      });
      if (this.auxOpcionList.length > 0 && i < this.auxOpcionList.length) {
        item[i] = this.auxOpcionList[i];
        this.agregarControlform(
          i,
          this.auxOpcionList[i].nombre,
          this.auxOpcionList[i].valor
        );
      } else {
        this.agregarControlform(
          i,
          this.defaultOptions[i].nombre,
          this.defaultOptions[i].valor
        );
      }
    }
    return item;
  }

  agregarControlform(index: number, valueOpcion: string, valor: number) {
    this.formulario.addControl(
      `opcion${this.opcion[index]}`,
      this.formBuilder.control(valueOpcion, [
        Validators.required,
        Validators.maxLength(200),
        Validators.pattern(exp_invalidos),
      ])
    );

    this.formulario.addControl(
      `valor${this.opcion[index]}`,
      this.formBuilder.control(valor, [
        Validators.required,
        Validators.min(1),
        Validators.max(5),
        Validators.pattern(exp_numeros),
      ])
    );
  }

  eliminarControlform(termino: string) {
    Object.keys(this.formulario.controls).forEach((controlName) => {
      if (controlName.includes(termino)) {
        this.formulario.removeControl(controlName);
      }
    });
  }
}
