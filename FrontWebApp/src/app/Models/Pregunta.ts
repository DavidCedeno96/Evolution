export interface Pregunta {
  idPregunta: string;
  nombre: string;
  opcionList: Opcion[];
}

export interface Opcion {
  idOpcion: string;
  idPregunta: string;
  nombre: string;
  correcta: number;
}
