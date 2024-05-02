import { Reto } from './Reto';

export interface Pregunta {
  idPregunta: string;
  idReto: string;
  nombre: string;
}

export interface Opcion {
  idOpcion: string;
  idPregunta: string;
  nombre: string;
  correcta: number;
  cantVotos: number;
}

export interface PreguntaOpciones {
  reto: Reto;
  pregunta: Pregunta;
  opcionList: Opcion[];
}
