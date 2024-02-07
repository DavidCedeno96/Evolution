import { Injectable } from '@angular/core';
import { servicioURL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UsuarioService } from './usuario.service';
import { Observable } from 'rxjs';
import { Pais } from '../Models/Adicional';

@Injectable({
  providedIn: 'root',
})
export class PaisService {
  private apiURL: string = servicioURL + '/api/pais';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getList(estado: number): Observable<Pais[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Pais[]>(`${this.apiURL}/list/${estado}`, {
      headers: headers,
    });
  }

  create(Pais: Pais): Observable<Pais> {
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<Pais>(`${this.apiURL}/create`, Pais, {
      headers: headers,
    });
  }

  update(Pais: Pais): Observable<Pais> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<Pais>(`${this.apiURL}/update`, Pais, {
      headers: headers,
    });
  }
}
