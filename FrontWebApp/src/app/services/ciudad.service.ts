import { Injectable } from '@angular/core';
import { API_URL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UsuarioService } from './usuario.service';
import { Ciudad } from '../Models/Adicional';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class CiudadService {
  private apiURL: string = API_URL + '/api/Ciudad';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getList(estado: number): Observable<Ciudad[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Ciudad[]>(`${this.apiURL}/list/${estado}`, {
      headers: headers,
    });
  }

  create(Ciudad: Ciudad): Observable<Ciudad> {
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<Ciudad>(`${this.apiURL}/create`, Ciudad, {
      headers: headers,
    });
  }

  update(Ciudad: Ciudad): Observable<Ciudad> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<Ciudad>(`${this.apiURL}/update`, Ciudad, {
      headers: headers,
    });
  }
}
