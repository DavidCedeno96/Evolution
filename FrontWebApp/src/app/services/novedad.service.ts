import { Injectable } from '@angular/core';
import { API_URL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UsuarioService } from './usuario.service';
import { Observable } from 'rxjs';
import { Novedad } from '../Models/Novedad';

@Injectable({
  providedIn: 'root',
})
export class NovedadService {
  private apiURL: string = API_URL + '/api/novedad';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getList(): Observable<Novedad[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Novedad[]>(`${this.apiURL}/list`, {
      headers: headers,
    });
  }

  updateEstado(notificacion: Novedad): Observable<Novedad> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<Novedad>(`${this.apiURL}/updateEstado`, notificacion, {
      headers: headers,
    });
  }

  delete(idNovedad: string): Observable<string> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.delete<string>(
      `${this.apiURL}/delete?idNovedad=${idNovedad}`,
      {
        headers: headers,
      }
    );
  }

  deleteByUsuario(): Observable<string> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.delete<string>(`${this.apiURL}/deleteByUsuario`, {
      headers: headers,
    });
  }
}
