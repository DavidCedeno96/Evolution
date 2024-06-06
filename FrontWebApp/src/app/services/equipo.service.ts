import { Injectable } from '@angular/core';
import { API_URL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UsuarioService } from './usuario.service';
import { Observable } from 'rxjs';
import { Equipo, Usuario_Equipo } from '../Models/Equipo';

@Injectable({
  providedIn: 'root',
})
export class EquipoService {
  private apiURL: string = API_URL + '/api/Equipo';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getList(estado: number): Observable<Equipo[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Equipo[]>(`${this.apiURL}/list/${estado}`, {
      headers: headers,
    });
  }

  getItem(estado: number, id: string): Observable<Equipo> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Equipo>(`${this.apiURL}/item/${estado}/${id}`, {
      headers: headers,
    });
  }

  getBuscarList(texto: string): Observable<Equipo[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Equipo[]>(`${this.apiURL}/buscar/${texto}`, {
      headers: headers,
    });
  }

  getUsuario_EquipoByIdEquipo(idEquipo: string): Observable<Usuario_Equipo[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Usuario_Equipo[]>(
      `${this.apiURL}/usuarioEquipoByIdEquipo/${idEquipo}`,
      {
        headers: headers,
      }
    );
  }

  getRanking(idUsuario: string, top: number): Observable<Usuario_Equipo[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Usuario_Equipo[]>(
      `${this.apiURL}/ranking/${top}/${idUsuario}`,
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

  createUsuario_Equipo(
    usuario_equipo: Usuario_Equipo
  ): Observable<Usuario_Equipo> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<Usuario_Equipo>(
      `${this.apiURL}/createUsuarioEquipo`,
      usuario_equipo,
      {
        headers: headers,
      }
    );
  }

  createUsuario_EquipoByCorreosIds(
    idEquipo: string,
    formData: FormData
  ): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<FormData>(
      `${this.apiURL}/massAction/createUsuarioEquipo/${idEquipo}`,
      formData,
      {
        headers: headers,
      }
    );
  }

  update(formData: FormData): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<FormData>(`${this.apiURL}/update`, formData, {
      headers: headers,
    });
  }

  updateEstado(equipo: Equipo): Observable<Equipo> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<Equipo>(`${this.apiURL}/updateEstado`, equipo, {
      headers: headers,
    });
  }

  delete(idEquipo: string): Observable<string> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.delete<string>(
      `${this.apiURL}/delete?idEquipo=${idEquipo}`,
      {
        headers: headers,
      }
    );
  }

  deleteUsuarioEquipo(idEquipo: string, idUsuario: string): Observable<string> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.delete<string>(
      `${this.apiURL}/deleteUsuarioEquipo/${idEquipo}/${idUsuario}`,
      {
        headers: headers,
      }
    );
  }
}
