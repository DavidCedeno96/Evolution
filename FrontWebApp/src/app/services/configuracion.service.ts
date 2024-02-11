import { Injectable } from '@angular/core';
import { servicioURL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UsuarioService } from './usuario.service';
import { Observable } from 'rxjs';
import { Configuracion } from '../Models/Configuracion';

@Injectable({
  providedIn: 'root',
})
export class ConfiguracionService {
  private apiURL: string = servicioURL + '/api/configuracion';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getList(): Observable<Configuracion[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Configuracion[]>(`${this.apiURL}/list`, {
      headers: headers,
    });
  }

  update(configuracion: Configuracion[]): Observable<Configuracion[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<Configuracion[]>(
      `${this.apiURL}/update`,
      configuracion,
      {
        headers: headers,
      }
    );
  }

  updateImages(formData: FormData): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<FormData>(`${this.apiURL}/updateImages`, formData, {
      headers: headers,
    });
  }
}
