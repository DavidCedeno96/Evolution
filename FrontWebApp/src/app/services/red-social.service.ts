import { Injectable } from '@angular/core';
import { API_URL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UsuarioService } from './usuario.service';
import { Observable } from 'rxjs';
import { RedSocial_Reaccion, Usuario_RedSocial } from '../Models/RedSocial';

@Injectable({
  providedIn: 'root',
})
export class RedSocialService {
  private apiURL: string = API_URL + '/api/redSocial';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getListAndComents(): Observable<RedSocial_Reaccion[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<RedSocial_Reaccion[]>(`${this.apiURL}/listByComents`, {
      headers: headers,
    });
  }

  getListUser(idRed: string): Observable<any> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<any>(`${this.apiURL}/user/${idRed}`, {
      headers: headers,
    });
  }

  createReaccion(
    Usuario_RedSocial: Usuario_RedSocial
  ): Observable<Usuario_RedSocial> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<Usuario_RedSocial>(
      `${this.apiURL}/createUsuarioRedSocial`,
      Usuario_RedSocial,
      {
        headers: headers,
      }
    );
  }
}
