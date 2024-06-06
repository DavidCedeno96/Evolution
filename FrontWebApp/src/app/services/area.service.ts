import { Injectable } from '@angular/core';
import { API_URL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UsuarioService } from './usuario.service';
import { Observable } from 'rxjs';
import { Area } from '../Models/Adicional';

@Injectable({
  providedIn: 'root',
})
export class AreaService {
  private apiURL: string = API_URL + '/api/area';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getList(estado: number): Observable<Area[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Area[]>(`${this.apiURL}/list/${estado}`, {
      headers: headers,
    });
  }

  create(Area: Area): Observable<Area> {
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<Area>(`${this.apiURL}/create`, Area, {
      headers: headers,
    });
  }

  update(Area: Area): Observable<Area> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<Area>(`${this.apiURL}/update`, Area, {
      headers: headers,
    });
  }
}
