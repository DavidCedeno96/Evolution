import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { UsuarioService } from './usuario.service';
import { servicioURL } from '../Utils/Constants';
import { Observable } from 'rxjs';
import { Nivel } from '../Models/Nivel';

@Injectable({
  providedIn: 'root',
})
export class NivelService {
  private apiURL: string = servicioURL + '/api/nivel';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getList(estado: number): Observable<Nivel[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Nivel[]>(`${this.apiURL}/list/${estado}`, {
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
}
