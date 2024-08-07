import { Injectable } from '@angular/core';
import { API_URL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UsuarioService } from './usuario.service';
import { Observable } from 'rxjs';
import { Noticia, Noticia_Reaccion, Usuario_Noticia } from '../Models/Noticia';

@Injectable({
  providedIn: 'root',
})
export class NoticiaService {
  private apiURL: string = API_URL + '/api/noticia';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getList(estado: number): Observable<Noticia[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Noticia[]>(`${this.apiURL}/list/${estado}`, {
      headers: headers,
    });
  }

  getListAndComents(
    estado: number,
    noticia: string
  ): Observable<Noticia_Reaccion[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Noticia_Reaccion[]>(
      `${this.apiURL}/listByComents/${estado}${noticia}`,
      {
        headers: headers,
      }
    );
  }

  getItem(estado: number, id: string): Observable<Noticia> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Noticia>(`${this.apiURL}/item/${estado}/${id}`, {
      headers: headers,
    });
  }

  getBuscarList(texto: string): Observable<Noticia[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Noticia[]>(`${this.apiURL}/buscar?texto=${texto}`, {
      headers: headers,
    });
  }

  createReaccion(
    usuario_noticia: Usuario_Noticia
  ): Observable<Usuario_Noticia> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<Usuario_Noticia>(
      `${this.apiURL}/createUsuarioNoticia`,
      usuario_noticia,
      {
        headers: headers,
      }
    );
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

  delete(idNoticia: string): Observable<string> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.delete<string>(
      `${this.apiURL}/delete?idNoticia=${idNoticia}`,
      {
        headers: headers,
      }
    );
  }
}
