import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { UsuarioService } from './usuario.service';
import { servicioURL } from '../Utils/Constants';
import { Empresa } from '../Models/Adicional';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class EmpresaService {
  private apiURL: string = servicioURL + '/api/empresa';

  constructor(
    private http: HttpClient,
    private usuarioServicio: UsuarioService
  ) {}

  getList(estado: number): Observable<Empresa[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.get<Empresa[]>(`${this.apiURL}/list/${estado}`, {
      headers: headers,
    });
  }

  create(Empresa: Empresa): Observable<Empresa> {
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.post<Empresa>(`${this.apiURL}/create`, Empresa, {
      headers: headers,
    });
  }

  update(Empresa: Empresa): Observable<Empresa> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.usuarioServicio.getToken()}`,
    });
    return this.http.put<Empresa>(`${this.apiURL}/update`, Empresa, {
      headers: headers,
    });
  }
}
