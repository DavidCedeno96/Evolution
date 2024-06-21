import { Injectable } from '@angular/core';
import { API_URL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UsuarioService } from './usuario.service';
import { Observable } from 'rxjs';
import { Categoria } from '../Models/Adicional';

@Injectable({
  providedIn: 'root',
})
export class CategoriaRecompensaService {
  private apiURL: string = API_URL + '/api/categoriaRecompensa';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getList(estado: number): Observable<Categoria[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Categoria[]>(`${this.apiURL}/list/${estado}`, {
      headers: headers,
    });
  }

  getBuscarList(texto: string): Observable<Categoria[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Categoria[]>(`${this.apiURL}/buscar?texto=${texto}`, {
      headers: headers,
    });
  }

  getItem(estado: number, id: string): Observable<Categoria> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Categoria>(`${this.apiURL}/item/${estado}/${id}`, {
      headers: headers,
    });
  }

  create(categoria: Categoria): Observable<Categoria> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<Categoria>(`${this.apiURL}/create`, categoria, {
      headers: headers,
    });
  }

  update(categoria: Categoria): Observable<Categoria> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<Categoria>(`${this.apiURL}/update`, categoria, {
      headers: headers,
    });
  }
}
