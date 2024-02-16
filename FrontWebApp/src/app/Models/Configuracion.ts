export interface Configuracion {
  idConfig: string;
  tipo: string;
  propiedad: string;
  nombre: string;
  valor: string;
  descripcion: string;
  idUsuario: string;
  usuario: string;
}

export interface ConfigInicio {
  idConfigInicio: string;
  nombre: string;
  indice: number;
  estado: number;
  idRol: string;
  color: string;
}
