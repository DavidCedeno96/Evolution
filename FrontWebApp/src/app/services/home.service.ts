import { Injectable } from '@angular/core';
import { API_URL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UsuarioService } from './usuario.service';
import { Observable } from 'rxjs';
import { ConfigInicio } from '../Models/Configuracion';

@Injectable({
  providedIn: 'root',
})
export class HomeService {
  private apiURL: string = API_URL + '/api/home';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getList(): Observable<any> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<any>(`${this.apiURL}/list`, {
      headers: headers,
    });
  }

  getUserList(): Observable<any> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<any>(`${this.apiURL}/user`, {
      headers: headers,
    });
  }

  update(
    configInicioList: ConfigInicio[],
    idRol: string
  ): Observable<ConfigInicio[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<ConfigInicio[]>(
      `${this.apiURL}/update/${idRol}`,
      configInicioList,
      {
        headers: headers,
      }
    );
  }
}
