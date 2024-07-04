import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { UsuarioService } from './usuario.service';
import { API_URL } from '../Utils/Constants';
import { CorreoEnvio } from '../Models/CorreoEnvio';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class CorreoEnvioService {
  private apiURL: string = API_URL + '/api/correoEnvio';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getItem(): Observable<CorreoEnvio[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<CorreoEnvio[]>(`${this.apiURL}/list`, {
      headers: headers,
    });
  }

  update(correoEnvio: CorreoEnvio): Observable<CorreoEnvio> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<CorreoEnvio>(`${this.apiURL}/update`, correoEnvio, {
      headers: headers,
    });
  }
}
