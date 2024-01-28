import { Component, OnInit } from '@angular/core';
import { Pregunta } from 'src/app/Models/Pregunta';

@Component({
  selector: 'app-trivia',
  templateUrl: './trivia.component.html',
  styleUrls: ['./trivia.component.css'],
})
export class TriviaComponent implements OnInit {
  preguntaActual: number = 0;
  nextText: string = 'Siguiente';
  nextButonDisable: boolean = false;
  opCorrecta: boolean = false;
  verOpCalificacion: boolean = false;
  selectedIndex: number = 0;

  pregunta: Pregunta[] = [
    {
      idPregunta: '',
      nombre:
        '¿Cuáles son los tres predadores del reino animal reconocidos por: 1) habilidad de cazar en grupo, 2) camuflajearse para sorprender a su presa, 3) poseer sentidos refinados?',
      opcionList: [
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '1) Tiburón blanco; 2) elefante; 3) escorpión',
          correcta: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '1) Leon; 2) elefante; 3) escorpión',
          correcta: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '1) Hiena; 2) Oso polar; 3) Lobo gris',
          correcta: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '1) Tigre; 2) águila; 3) gato',
          correcta: 1,
        },
      ],
    },
    {
      idPregunta: '',
      nombre: '¿Cuantos años tengo?',
      opcionList: [
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '23 años',
          correcta: 1,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '24 años',
          correcta: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '25 años',
          correcta: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '26 años',
          correcta: 0,
        },
      ],
    },
    {
      idPregunta: '',
      nombre: 'Cual es el pais mas pequeño del mundo',
      opcionList: [
        {
          idOpcion: '',
          idPregunta: '',
          nombre: 'Ecuador',
          correcta: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: 'Uruguay',
          correcta: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: 'El Vaticano',
          correcta: 1,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: 'Suecia',
          correcta: 0,
        },
      ],
    },
  ];

  ngOnInit(): void {}

  next() {
    /* console.log(this.formulario.valid);
    console.log(this.formulario.value); */

    if (this.preguntaActual === this.pregunta.length - 1) {
      this.opCalificacion(true, false);
      setTimeout(() => {
        //this.opCalificacion(false, true);
        this.finalizarTrivia();
      }, 2500);
    }
    if (this.preguntaActual < this.pregunta.length - 1) {
      this.opCalificacion(true, false);
      setTimeout(() => {
        this.preguntaActual += 1;
        this.opCalificacion(false, true);

        if (this.preguntaActual === this.pregunta.length - 1) {
          this.nextText = 'Finalizar';
        }
      }, 2500);
    }
  }

  calificarOpcion(index: number, correcta: number) {
    this.selectedIndex = index;
    if (correcta === 1) {
      this.opCorrecta = true;
    } else {
      this.opCorrecta = false;
    }
  }

  cambiarTextColor(index: number): string {
    if (this.selectedIndex > 0 && this.selectedIndex === index) {
      if (this.opCorrecta && this.verOpCalificacion) {
        return 'fw-semibold text-success';
      } else if (this.verOpCalificacion) {
        return 'fw-semibold text-danger text-decoration-line-through';
      }
    } else if (this.selectedIndex === 0 && this.verOpCalificacion) {
      return 'fw-semibold text-danger';
    }
    return 'text-body';
  }

  opCalificacion(btn_Op: boolean, index0: boolean) {
    this.nextButonDisable = btn_Op;
    this.verOpCalificacion = btn_Op;
    if (index0) {
      this.selectedIndex = 0;
    }
  }

  validarPregunta() {}

  finalizarTrivia() {
    console.log('FINALIZANDO TRIVIA');
  }
}
