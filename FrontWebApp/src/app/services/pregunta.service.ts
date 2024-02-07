import { Injectable } from '@angular/core';
import { servicioURL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UsuarioService } from './usuario.service';
import { PreguntaOpciones } from '../Models/Pregunta';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class PreguntaService {
  private apiURL: string = servicioURL + '/api/pregunta';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getArchivo(): Observable<Blob> {
    return this.http.get('assets/archivos/FormatoPreguntasReto.xlsx', {
      responseType: 'blob',
    });
  }

  getList(estado: number, idReto: string): Observable<PreguntaOpciones[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<PreguntaOpciones[]>(
      `${this.apiURL}/listByIdReto/${estado}/${idReto}`,
      {
        headers: headers,
      }
    );
  }

  getItem(estado: number, id: string): Observable<PreguntaOpciones> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<PreguntaOpciones>(
      `${this.apiURL}/item/${estado}/${id}`,
      {
        headers: headers,
      }
    );
  }

  getBuscarList(texto: string, idReto: string): Observable<PreguntaOpciones[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<PreguntaOpciones[]>(
      `${this.apiURL}/buscar/${texto}/${idReto}`,
      {
        headers: headers,
      }
    );
  }

  create(preguntaOpciones: PreguntaOpciones): Observable<PreguntaOpciones> {
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<PreguntaOpciones>(
      `${this.apiURL}/create`,
      preguntaOpciones,
      {
        headers: headers,
      }
    );
  }

  update(preguntaOpciones: PreguntaOpciones): Observable<PreguntaOpciones> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<PreguntaOpciones>(
      `${this.apiURL}/update`,
      preguntaOpciones,
      {
        headers: headers,
      }
    );
  }

  delete(idPregunta: string): Observable<string> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.delete<string>(`${this.apiURL}/delete/${idPregunta}`, {
      headers: headers,
    });
  }

  enviarArchivo(formData: FormData, idReto: string): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    //headers.append('Access-Control-Allow-Credentials', 'true');
    return this.http.post<FormData>(
      `${this.apiURL}/import/${idReto}`,
      formData,
      {
        headers: headers,
      }
    );
  }
}
