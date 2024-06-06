import { Injectable } from '@angular/core';
import { API_URL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { UsuarioService } from './usuario.service';
import { Adicional } from '../Models/Adicional';

@Injectable({
  providedIn: 'root',
})
export class AdicionalService {
  private apiURL: string = API_URL + '/api/adicional';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getListUsuario(estado: number): Observable<Adicional> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Adicional>(`${this.apiURL}/usuario/${estado}`, {
      headers: headers,
    });
  }

  getListReto(estado: number): Observable<Adicional> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Adicional>(`${this.apiURL}/reto/${estado}`, {
      headers: headers,
    });
  }

  getListNoticia(estado: number): Observable<Adicional> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Adicional>(`${this.apiURL}/noticia/${estado}`, {
      headers: headers,
    });
  }

  getListRecompensa(estado: number): Observable<Adicional> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Adicional>(`${this.apiURL}/recompensa/${estado}`, {
      headers: headers,
    });
  }

  getListMedalla(estado: number): Observable<Adicional> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Adicional>(`${this.apiURL}/medalla/${estado}`, {
      headers: headers,
    });
  }

  getListOpcion(estado: number): Observable<Adicional> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Adicional>(`${this.apiURL}/opcion/${estado}`, {
      headers: headers,
    });
  }
}
