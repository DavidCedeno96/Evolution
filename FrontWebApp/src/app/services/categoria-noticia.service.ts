import { Injectable } from '@angular/core';
import { servicioURL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UsuarioService } from './usuario.service';
import { Observable } from 'rxjs';
import { Categoria } from '../Models/Adicional';

@Injectable({
  providedIn: 'root',
})
export class CategoriaNoticiaService {
  private apiURL: string = servicioURL + '/api/categoriaNoticia';

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
}
