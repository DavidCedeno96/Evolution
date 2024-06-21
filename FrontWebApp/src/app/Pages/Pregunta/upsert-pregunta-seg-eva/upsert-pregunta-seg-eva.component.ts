import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { TipoEntrada } from 'src/app/Models/Adicional';
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
import { AdicionalService } from 'src/app/services/adicional.service';
import { PreguntaService } from 'src/app/services/pregunta.service';

@Component({
  selector: 'app-upsert-pregunta-seg-eva',
  templateUrl: './upsert-pregunta-seg-eva.component.html',
  styleUrls: ['./upsert-pregunta-seg-eva.component.css'],
})
export class UpsertPreguntaSegEvaComponent implements OnInit, AfterViewInit {
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
  campo: string = '';
  error: number = 0;
  info: string = '';

  tipoEntrada: TipoEntrada[] = [];

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
    private formBuilder: FormBuilder,
    private adicionalServicio: AdicionalService
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

  ngAfterViewInit(): void {
    if (this.type === 'editar') {
      this.loading(true, false);
      this.cargarPregunta(this.id);
    }
  }

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
          this.cargaOpciones(0, this.preguntaOpciones);
          break;
        }
        case 'editar': {
          this.id = idPregunta;
          this.titulo = 'editar pregunta';
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

  cargarAdicionales() {
    this.adicionalServicio.getListOpcion(1).subscribe({
      next: (data: any) => {
        let { tipoEntradaList } = data.response;
        this.tipoEntrada = tipoEntradaList.lista;
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
    //let opCorrecta: string = this.formulario.get(['opcionCorrecta'])?.value;

    for (let i = 0; i < numOpciones; i++) {
      let opcion: Opcion = {
        idOpcion: '7c8c2672-2233-486a-a184-f0b51eb4a331',
        idPregunta: '7c8c2672-2233-486a-a184-f0b51eb4a331',
        idTipoEntrada: '',
        tipoEntrada: '',
        nombre: '',
        correcta: 0,
        cantVotos: 0,
        valor: 0,
        cantVotosXvalor: 0,
      };
      opcion.nombre = this.formulario.get(['opcion' + this.opcion[i]])?.value;
      opcion.idTipoEntrada = this.formulario.get([
        'idTipoEntrada' + this.opcion[i],
      ])?.value;

      /* if (this.opcion[i] === opCorrecta) {
        opcion.correcta = 1;
      } */
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
          this.auxOpcionList[i].idTipoEntrada
        );
      } else {
        this.agregarControlform(i, '', '');
      }
    }
    return item;
  }

  agregarControlform(index: number, value: string, idTipoEntrada: string) {
    this.formulario.addControl(
      `opcion${this.opcion[index]}`,
      this.formBuilder.control(value, [
        Validators.required,
        Validators.maxLength(200),
        Validators.pattern(exp_invalidos),
      ])
    );

    this.formulario.addControl(
      `idTipoEntrada${this.opcion[index]}`,
      this.formBuilder.control(idTipoEntrada, [Validators.required])
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
