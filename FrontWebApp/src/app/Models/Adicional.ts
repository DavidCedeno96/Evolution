export interface Pais {
  idPais: string;
  nombre: string;
  descripcion: string;
  estado: number;
}

export interface Ciudad {
  idCiudad: string;
  nombre: string;
  descripcion: string;
  idPais: string;
  Pais: string;
  estado: number;
}

export interface Empresa {
  idEmpresa: string;
  nombre: string;
  descripcion: string;
  estado: number;
}

export interface Area {
  idArea: string;
  nombre: string;
  descripcion: string;
  idEmpresa: string;
  Empresa: string;
  estado: number;
}

export interface TipoReto {
  idTipoReto: string;
  nombre: string;
  descripcion: string;
  estado: number;
}

export interface ComportamientoPregunta {
  idComportamiento: string;
  nombre: string;
  descripcion: string;
  estado: number;
}

export interface Categoria {
  idCategoria: string;
  nombre: string;
  descripcion: string;
  estado: number;
}

export interface Condicion {
  idCondicion: string;
  nombre: string;
  descripcion: string;
  estado: string;
}

export interface Adicional {
  paisList: Pais[];
  ciudadList: Ciudad[];
  empresaList: Empresa[];
  areaList: Area[];
  tipoRetoList: TipoReto[];
  comportPregList: ComportamientoPregunta[];
  categoriaList: Categoria[];
  condicionList: Condicion[];
}
