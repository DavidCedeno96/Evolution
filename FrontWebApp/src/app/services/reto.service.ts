import { Injectable } from '@angular/core';
import { servicioURL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Equipo_Reto, Reto, Usuario_Reto } from '../Models/Reto';
import { UsuarioService } from './usuario.service';

@Injectable({
  providedIn: 'root',
})
export class RetoService {
  private apiURL: string = servicioURL + '/api/reto';

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
    return this.http.get<Reto[]>(`${this.apiURL}/buscar/${texto}`, {
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

  getUsuario_RetoByIdReto(idReto: string): Observable<Usuario_Reto[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Usuario_Reto[]>(
      `${this.apiURL}/usuarioRetoByIdReto/${idReto}`,
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
      `${this.apiURL}/buscarUsuarioRetoByIdUsuario/${texto}`,
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

  /* enviarArchivo(formData: FormData, idReto: string): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<FormData>(
      `${this.apiURL}/importUsuarioReto/${idReto}`,
      formData,
      {
        headers: headers,
      }
    );
  } */

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
