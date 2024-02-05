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
}

export interface PreguntaOpciones {
  pregunta: Pregunta;
  opcionList: Opcion[];
}
