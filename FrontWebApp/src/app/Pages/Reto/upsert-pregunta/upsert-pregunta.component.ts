import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Opcion, Pregunta } from 'src/app/Models/Pregunta';
import {
  AlertError,
  Loading,
  MsgErrorForm,
  TitleErrorForm,
} from 'src/app/Utils/Constants';

@Component({
  selector: 'app-upsert-pregunta',
  templateUrl: './upsert-pregunta.component.html',
  styleUrls: ['./upsert-pregunta.component.css'],
})
export class UpsertPreguntaComponent implements OnInit, AfterViewInit {
  auxIdPregunta: string = '';
  auxOpcionList: Opcion[] = [];
  opcion: string[] = ['A', 'B', 'C', 'D'];

  verErrorsInputs: boolean = false;
  numClicksSave: number = 0;

  formulario!: FormGroup;

  pregunta: Pregunta = {
    idPregunta: '',
    nombre: '',
    opcionList: [],
  };

  constructor(private formBuilder: FormBuilder) {
    this.formulario = this.formBuilder.group({
      pregunta: [
        this.pregunta.nombre,
        [Validators.required, Validators.maxLength(200)],
      ],
      totalOpciones: ['', [Validators.required]],
    });
  }

  ngOnInit(): void {
    //this.cargaOpciones(0, this.pregunta); // este es cuando el tipo sea 'crear'
    this.cargarData(); // este es cuando el tipo sea 'editar'
  }

  ngAfterViewInit(): void {}

  cargarData() {
    let preguntaDB: Pregunta = {
      idPregunta: '',
      nombre: '¿Cuál es el grupo de palabras escritas correctamente?',
      opcionList: [
        {
          idOpcion: '',
          idPregunta: '',
          nombre: 'Metaformosis, estranjero, diversidad, ekilibrio',
          correcta: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: 'Metamorfosis, extrangero, dibersidad, equilibrio',
          correcta: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: 'Metamorfosis, extranjero, diversidad, equilibrio',
          correcta: 1,
        },
      ],
    };

    this.pregunta = preguntaDB;
    this.auxOpcionList = preguntaDB.opcionList;

    let totalOpciones = preguntaDB.opcionList.length;
    this.cargaOpciones(totalOpciones, preguntaDB);
  }

  cargaOpciones(totalOpciones: number, pregunta: Pregunta) {
    if (totalOpciones > 1 && totalOpciones < 5) {
      this.formulario.patchValue({
        pregunta: pregunta.nombre,
        totalOpciones: totalOpciones,
      });

      this.pregunta.opcionList = this.opcionItem(totalOpciones);
    } else {
      this.pregunta.opcionList = [];
    }
  }

  save() {
    console.log(this.formulario.valid);
    console.log(this.formulario.value);

    this.numClicksSave += 1;
    if (this.formulario.valid) {
      this.verErrorsInputs = false;
      console.log('Creando Pregunta...');
    } else {
      this.verErrorsInputs = true;

      AlertError(TitleErrorForm, MsgErrorForm);
    }
  }

  selectTotalOpciones(event: Event) {
    const selectedValue = (event.target as HTMLSelectElement).value;
    if (Number(selectedValue) < 5) {
      this.pregunta.opcionList = this.opcionItem(Number(selectedValue));
    } else {
      this.pregunta.opcionList = [];
    }
  }

  opcionItem(num: number): Opcion[] {
    var item = [];
    this.eliminarControlform('opcion');
    for (let i = 0; i < num; i++) {
      item.push({
        idOpcion: '',
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
