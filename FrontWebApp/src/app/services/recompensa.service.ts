import { Injectable } from '@angular/core';
import { servicioURL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UsuarioService } from './usuario.service';
import { Observable } from 'rxjs';
import { Recompensa, Usuario_Recompensa } from '../Models/Recompensa';

@Injectable({
  providedIn: 'root',
})
export class RecompensaService {
  private apiURL: string = servicioURL + '/api/recompensa';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getArchivo(): Observable<Blob> {
    return this.http.get('assets/archivos/FormatoRecompensas.xlsx', {
      responseType: 'blob',
    });
  }

  getList(estado: number): Observable<Recompensa[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Recompensa[]>(`${this.apiURL}/list/${estado}`, {
      headers: headers,
    });
  }

  getItem(estado: number, id: string): Observable<Recompensa> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Recompensa>(`${this.apiURL}/item/${estado}/${id}`, {
      headers: headers,
    });
  }

  getBuscarList(texto: string): Observable<Recompensa[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Recompensa[]>(`${this.apiURL}/buscar/${texto}`, {
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

  delete(idRecompensa: string): Observable<string> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.delete<string>(
      `${this.apiURL}/delete?idRecompensa=${idRecompensa}`,
      {
        headers: headers,
      }
    );
  }

  enviarArchivo(formData: FormData): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<FormData>(`${this.apiURL}/import`, formData, {
      headers: headers,
    });
  }

  cajearRecompensa(
    usuario_recompensa: Usuario_Recompensa
  ): Observable<Usuario_Recompensa> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<Usuario_Recompensa>(
      `${this.apiURL}/createUsuarioRecompensa`,
      usuario_recompensa,
      {
        headers: headers,
      }
    );
  }
}
