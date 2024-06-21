import { Injectable } from '@angular/core';
import { API_URL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Equipo_Reto, Reto, Usuario_Reto } from '../Models/Reto';
import { UsuarioService } from './usuario.service';

@Injectable({
  providedIn: 'root',
})
export class RetoService {
  private apiURL: string = API_URL + '/api/reto';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getArchivo(): Observable<Blob> {
    return this.http.get('assets/archivos/FormatoUsuariosRetos.xlsx', {
      responseType: 'blob',
    });
  }

  getList(estado: number): Observable<Reto[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Reto[]>(`${this.apiURL}/list/${estado}`, {
      headers: headers,
    });
  }

  getItem(estado: number, id: string): Observable<Reto> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Reto>(`${this.apiURL}/item/${estado}/${id}`, {
      headers: headers,
    });
  }

  getBuscarList(texto: string): Observable<Reto[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Reto[]>(`${this.apiURL}/buscar?texto=${texto}`, {
      headers: headers,
    });
  }

  getRanking(top: number): Observable<Reto[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Reto[]>(`${this.apiURL}/ranking/${top}`, {
      headers: headers,
    });
  }

  getUsuario_RetoByIdReto(
    idReto: string,
    validador: number
  ): Observable<Usuario_Reto[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Usuario_Reto[]>(
      `${this.apiURL}/usuarioRetoByIdReto/${idReto}/${validador}`,
      {
        headers: headers,
      }
    );
  }

  getUsuario_RetoByIdUsuario(): Observable<Usuario_Reto[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Usuario_Reto[]>(
      `${this.apiURL}/usuarioRetoByIdUsuario`,
      {
        headers: headers,
      }
    );
  }

  getUsuario_RetoByIdUsuarioYIdReto(
    idReto: string
  ): Observable<Usuario_Reto[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Usuario_Reto[]>(
      `${this.apiURL}/usuarioRetoByIdUsuarioYIdReto/${idReto}`,
      {
        headers: headers,
      }
    );
  }

  getBuscarUsuario_RetoByIdUsuario(texto: string): Observable<Reto[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Reto[]>(
      `${this.apiURL}/buscarUsuarioRetoByIdUsuario?texto=${texto}`,
      {
        headers: headers,
      }
    );
  }

  getEquipoByReto(idReto: string, estado: number): Observable<Equipo_Reto[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Equipo_Reto[]>(
      `${this.apiURL}/equiposByReto/${idReto}/${estado}`,
      {
        headers: headers,
      }
    );
  }

  getRetosXValidar(top: number): Observable<Usuario_Reto[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Usuario_Reto[]>(
      `${this.apiURL}/retosXvalidar/${top}`,
      {
        headers: headers,
      }
    );
  }

  getRetosXValidarUsuarios(idReto: string): Observable<Usuario_Reto[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Usuario_Reto[]>(
      `${this.apiURL}/retosXvalidar/usuarios/${idReto}`,
      {
        headers: headers,
      }
    );
  }

  getZipArchivos(
    idReto: string,
    idUsuario: string
  ): Observable<Usuario_Reto[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Usuario_Reto[]>(
      `${this.apiURL}/descargar-zip/archivos/${idReto}/${idUsuario}`,
      {
        headers: headers,
      }
    );
  }

  createUsuario_Reto(usuario_reto: Usuario_Reto): Observable<Usuario_Reto> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<Usuario_Reto>(
      `${this.apiURL}/createUsuarioReto`,
      usuario_reto,
      {
        headers: headers,
      }
    );
  }

  createUsuario_RetoByCorreosIds(
    idReto: string,
    formData: FormData
  ): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<FormData>(
      `${this.apiURL}/massAction/createUsuarioReto/${idReto}`,
      formData,
      {
        headers: headers,
      }
    );
  }

  createEquipo_Reto(idReto: string, formData: FormData): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<FormData>(
      `${this.apiURL}/createEquipoReto/${idReto}`,
      formData,
      {
        headers: headers,
      }
    );
  }

  createUsuarioxOpciones(formData: FormData): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<FormData>(
      `${this.apiURL}/create/usuarioxOpcion/comportamiento`,
      formData,
      {
        headers: headers,
      }
    );
  }

  create(formData: FormData): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<FormData>(`${this.apiURL}/create`, formData, {
      headers: headers,
    });
  }

  update(formData: FormData): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<FormData>(`${this.apiURL}/update`, formData, {
      headers: headers,
    });
  }

  updateUsuario_retoTrivia(
    usuarioReto: Usuario_Reto
  ): Observable<Usuario_Reto> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<Usuario_Reto>(
      `${this.apiURL}/updateUsuarioReto/trivia`,
      usuarioReto,
      {
        headers: headers,
      }
    );
  }

  updateUsuario_retoEncuesta(formData: FormData): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<FormData>(
      `${this.apiURL}/updateUsuarioReto/encuesta`,
      formData,
      {
        headers: headers,
      }
    );
  }

  updateUsuario_retoSeg_evaluacion(formData: FormData): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<FormData>(
      `${this.apiURL}/updateUsuarioReto/seguimiento_evaluacion`,
      formData,
      {
        headers: headers,
      }
    );
  }

  updateUsuario_retoRecoleccionPerdiente(
    formData: FormData
  ): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<FormData>(
      `${this.apiURL}/updateUsuarioReto/recoleccion/pendiente`,
      formData,
      {
        headers: headers,
      }
    );
  }

  updateUsuario_retoRecoleccionFinalizado(
    formData: FormData,
    puntos: number
  ): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<FormData>(
      `${this.apiURL}/updateUsuarioReto/recoleccion/finalizado/${puntos}`,
      formData,
      {
        headers: headers,
      }
    );
  }

  updateUsuario_retoRecoleccionFinalizadoMasivo(
    formData: FormData,
    puntos: number
  ): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<FormData>(
      `${this.apiURL}/updateUsuarioReto/recoleccion/finalizado/masivo/${puntos}`,
      formData,
      {
        headers: headers,
      }
    );
  }

  updateEstado(reto: Reto): Observable<Reto> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<Reto>(`${this.apiURL}/updateEstado`, reto, {
      headers: headers,
    });
  }

  delete(idReto: string): Observable<string> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.delete<string>(`${this.apiURL}/delete?idReto=${idReto}`, {
      headers: headers,
    });
  }

  deleteUsuarioReto(idReto: string, idUsuario: string): Observable<string> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.delete<string>(
      `${this.apiURL}/deleteUsuarioReto/${idReto}/${idUsuario}`,
      {
        headers: headers,
      }
    );
  }

  deleteEquipoReto(idReto: string, idEquipo: string): Observable<string> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.delete<string>(
      `${this.apiURL}/deleteEquipoReto/${idReto}/${idEquipo}`,
      {
        headers: headers,
      }
    );
  }
}
