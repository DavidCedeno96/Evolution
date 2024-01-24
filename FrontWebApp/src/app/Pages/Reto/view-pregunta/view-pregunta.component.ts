import { Component, OnInit } from '@angular/core';
import { Pregunta } from 'src/app/Models/Pregunta';

@Component({
  selector: 'app-view-pregunta',
  templateUrl: './view-pregunta.component.html',
  styleUrls: ['./view-pregunta.component.css'],
})
export class ViewPreguntaComponent implements OnInit {
  pregunta: Pregunta[] = [
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
      nombre: '¿Cuál es el grupo de palabras escritas correctamente?',
      opcionList: [
        {
          idOpcion: '',
          idPregunta: '',
          nombre: 'Metamorfosis, extranjero, diversidac, equilivrio',
          correcta: 0,
        },
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
    },
    {
      idPregunta: '',
      nombre:
        '¿Cuáles son los representantes más destacados de la literatura renacentista?',
      opcionList: [
        {
          idOpcion: '',
          idPregunta: '',
          nombre:
            'Leonardo da Vinci, Miguel Angel Buonarroti, Sandro Boticelli',
          correcta: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: 'Miguel de Cervantes, William Shakespeare, Luis de Camões.',
          correcta: 1,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: 'Caravaggio, Bernini, Borromini',
          correcta: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: 'Goethe, Victor Hugo, Gustavo Adolfo Bécquer',
          correcta: 0,
        },
      ],
    },
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
          nombre: '1) León; 2) tiburón blanco; 3) orca',
          correcta: 0,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '1) Hiena; 2) Oso polar; 3) Lobo gris',
          correcta: 1,
        },
        {
          idOpcion: '',
          idPregunta: '',
          nombre: '1) Tigre; 2) águila; 3) gato',
          correcta: 0,
        },
      ],
    },
  ];

  ngOnInit(): void {}
}
