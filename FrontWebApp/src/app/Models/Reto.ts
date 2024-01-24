export interface Reto {
  idReto: string;
  nombre: string;
  fechaApertura: Date;
  fechaCierre: Date;
  vidas: number;
  tiempo_ms: number;
  puntosRecompensa: number;
  creditosObtenidos: number;
  instrucciones: string;
  imagen: string;
  idTipoReto: string;
  tipoReto: string;
  idComportamiento: string;
  comportamiento: string;
  estado: number;
}
