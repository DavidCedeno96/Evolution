import { Injectable } from '@angular/core';
import { servicioURL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { Reto } from '../Models/Reto';
import { UsuarioService } from './usuario.service';

@Injectable({
  providedIn: 'root',
})
export class RetoService {
  private apiURL: string = servicioURL + '/api/reto';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getList(estado: number): Observable<Reto[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Reto[]>(`${this.apiURL}/list/${estado}`, {
      headers: headers,
    });
  }

  getItem(estado: number, id: string): Observable<Reto> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Reto>(`${this.apiURL}/item/${estado}/${id}`, {
      headers: headers,
    });
  }

  getBuscarList(texto: string): Observable<Reto[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Reto[]>(`${this.apiURL}/buscar/${texto}`, {
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

  delete(idReto: string): Observable<string> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.delete<string>(`${this.apiURL}/delete?idReto=${idReto}`, {
      headers: headers,
    });
  }
}
