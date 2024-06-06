import { Injectable } from '@angular/core';
import { API_URL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UsuarioService } from './usuario.service';
import { Observable } from 'rxjs';
import { Notificacion } from '../Models/Notificacion';

@Injectable({
  providedIn: 'root',
})
export class NotificacionService {
  private apiURL: string = API_URL + '/api/notificacion';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getList(estado: number): Observable<Notificacion[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Notificacion[]>(`${this.apiURL}/list/${estado}`, {
      headers: headers,
    });
  }

  getItem(id: string): Observable<Notificacion> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Notificacion>(`${this.apiURL}/item/${id}`, {
      headers: headers,
    });
  }

  update(notificacion: Notificacion): Observable<Notificacion> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<Notificacion>(`${this.apiURL}/update`, notificacion, {
      headers: headers,
    });
  }

  updateEstado(notificacion: Notificacion): Observable<Notificacion> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<Notificacion>(
      `${this.apiURL}/updateEstado`,
      notificacion,
      {
        headers: headers,
      }
    );
  }
}
