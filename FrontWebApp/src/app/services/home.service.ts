import { Injectable } from '@angular/core';
import { servicioURL } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UsuarioService } from './usuario.service';
import { Observable } from 'rxjs';
import { ConfigInicio } from '../Models/Configuracion';

@Injectable({
  providedIn: 'root',
})
export class HomeService {
  private apiURL: string = servicioURL + '/api/home';

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

  getListByRol(idRol: string): Observable<any> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<any>(`${this.apiURL}/list/${idRol}`, {
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

  getJugadorList(): Observable<any> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<any>(`${this.apiURL}/jugador`, {
      headers: headers,
    });
  }

  getAdminList(): Observable<any> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<any>(`${this.apiURL}/admin`, {
      headers: headers,
    });
  }
}
