import { Injectable } from '@angular/core';
import { servicioURL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UsuarioService } from './usuario.service';
import { Medalla } from '../Models/Medalla';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class MedallaService {
  private apiURL: string = servicioURL + '/api/medalla';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getList(estado: number): Observable<Medalla[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Medalla[]>(`${this.apiURL}/list/${estado}`, {
      headers: headers,
    });
  }

  getItem(estado: number, id: string): Observable<Medalla> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Medalla>(`${this.apiURL}/item/${estado}/${id}`, {
      headers: headers,
    });
  }

  getBuscarList(texto: string): Observable<Medalla[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Medalla[]>(`${this.apiURL}/buscar/${texto}`, {
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

  delete(idMedalla: string): Observable<string> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.delete<string>(
      `${this.apiURL}/delete?idMedalla=${idMedalla}`,
      {
        headers: headers,
      }
    );
  }
}
