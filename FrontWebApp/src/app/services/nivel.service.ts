import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { UsuarioService } from './usuario.service';
import { API_URL } from '../Utils/Constants';
import { Observable } from 'rxjs';
import { Nivel, Usuario_Nivel } from '../Models/Nivel';

@Injectable({
  providedIn: 'root',
})
export class NivelService {
  private apiURL: string = API_URL + '/api/nivel';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getArchivo(): Observable<Blob> {
    return this.http.get('assets/archivos/FormatoNiveles.xlsx', {
      responseType: 'blob',
    });
  }

  reporteNivel(estado: number): Observable<any> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<any>(`${this.apiURL}/reporte/nivel/${estado}`, {
      headers: headers,
    });
  }

  getList(estado: number): Observable<Nivel[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Nivel[]>(`${this.apiURL}/list/${estado}`, {
      headers: headers,
    });
  }

  getListByUsuario(): Observable<Nivel[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Nivel[]>(`${this.apiURL}/list`, {
      headers: headers,
    });
  }

  getItem(estado: number, id: string): Observable<Nivel> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Nivel>(`${this.apiURL}/item/${estado}/${id}`, {
      headers: headers,
    });
  }

  getBuscarList(texto: string): Observable<Nivel[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Nivel[]>(`${this.apiURL}/buscar/${texto}`, {
      headers: headers,
    });
  }

  create(formData: FormData): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<FormData>(`${this.apiURL}/create`, formData, {
      headers: headers,
    });
  }

  createUsuarioNivel(usuarioNivel: Usuario_Nivel): Observable<Usuario_Nivel> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<Usuario_Nivel>(
      `${this.apiURL}/createUsuarioNivel`,
      usuarioNivel,
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

  delete(idNivel: string): Observable<string> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.delete<string>(
      `${this.apiURL}/delete?idNivel=${idNivel}`,
      {
        headers: headers,
      }
    );
  }

  enviarArchivo(formData: FormData): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<FormData>(`${this.apiURL}/import`, formData, {
      headers: headers,
    });
  }
}
