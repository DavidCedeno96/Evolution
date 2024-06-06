//import { Reto } from './Reto';

export interface Pregunta {
  idPregunta: string;
  idReto: string;
  nombre: string;
}

export interface Opcion {
  idOpcion: string;
  idPregunta: string;
  idTipoEntrada: string;
  tipoEntrada: string;
  nombre: string;
  correcta: number;
  cantVotos: number;
  valor: number;
}

export interface PreguntaOpciones {
  pregunta: Pregunta;
  opcionList: Opcion[];
}
