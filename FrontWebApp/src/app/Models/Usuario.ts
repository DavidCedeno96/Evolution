export interface Usuario {
  idUsuario: string;
  nombre: string;
  apellido: string;
  correo: string;
  id: string; // es la cedula, pasaporte, etc etc.
  paisCode: string;
  paisIso2: string;
  celular: string;
  foto: string;
  idRol: string;
  rol: string;
  idPais: string;
  pais: string;
  idCiudad: string;
  ciudad: string;
  idEmpresa: string;
  empresa: string;
  idArea: string;
  area: string;
  contrasena: string;
  puntos: number;
  creditos: number;
  estado: number;
}
