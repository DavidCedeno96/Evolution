import { Injectable } from '@angular/core';
import { API_URL } from '../Utils/Constants';
import { Router } from '@angular/router';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Usuario } from '../Models/Usuario';
import { Observable } from 'rxjs';
import { JwtHelperService } from '@auth0/angular-jwt';

@Injectable({
  providedIn: 'root',
})
export class UsuarioService {
  private apiURL: string = API_URL + '/api/usuario';

  helper = new JwtHelperService();
  private timeoutId!: number;
  private tiempoDeInactividad: number = 1200000; // esta en milisegundos

  constructor(private http: HttpClient, private router: Router) {}

  getArchivo(): Observable<Blob> {
    return this.http.get('assets/archivos/FormatoUsuarios.xlsx', {
      responseType: 'blob',
    });
  }

  reporteUsuarios(estado: number): Observable<any> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.getToken()}`,
    });
    return this.http.get<any>(`${this.apiURL}/reporte/usuario/${estado}`, {
      headers: headers,
    });
  }

  getList(estado: number): Observable<Usuario[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.getToken()}`,
    });
    return this.http.get<Usuario[]>(`${this.apiURL}/list/${estado}`, {
      headers: headers,
    });
  }

  getBuscarList(texto: string): Observable<Usuario[]> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.getToken()}`,
    });
    return this.http.get<Usuario[]>(`${this.apiURL}/buscar?texto=${texto}`, {
      headers: headers,
    });
  }

  getItem(estado: number, id: string): Observable<Usuario> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.getToken()}`,
    });
    return this.http.get<Usuario>(`${this.apiURL}/item/${estado}/${id}`, {
      headers: headers,
    });
  }

  getLogros(id: string): Observable<Usuario> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.getToken()}`,
    });
    return this.http.get<Usuario>(`${this.apiURL}/logros/${id}`, {
      headers: headers,
    });
  }

  create(formData: FormData): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.getToken()}`,
    });
    return this.http.post<FormData>(`${this.apiURL}/create`, formData, {
      headers: headers,
    });
  }

  update(formData: FormData): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.getToken()}`,
    });
    return this.http.put<FormData>(`${this.apiURL}/update`, formData, {
      headers: headers,
    });
  }

  updateUser(formData: FormData): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.getToken()}`,
    });
    return this.http.put<FormData>(`${this.apiURL}/updateUser`, formData, {
      headers: headers,
    });
  }

  updateByFoto(formData: FormData): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.getToken()}`,
    });
    return this.http.put<FormData>(`${this.apiURL}/updateFoto`, formData, {
      headers: headers,
    });
  }

  updateEstado(usuario: Usuario): Observable<Usuario> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.getToken()}`,
    });
    return this.http.put<Usuario>(`${this.apiURL}/updateEstado`, usuario, {
      headers: headers,
    });
  }

  updateEstadoByCorreosIds(formData: FormData): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.getToken()}`,
    });
    return this.http.put<FormData>(
      `${this.apiURL}/massAction/updateEstado`,
      formData,
      {
        headers: headers,
      }
    );
  }

  register(formData: FormData): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.getToken()}`,
    });
    return this.http.post<FormData>(`${this.apiURL}/register`, formData, {
      headers: headers,
    });
  }

  enviarArchivo(formData: FormData): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.getToken()}`,
    });
    return this.http.post<FormData>(`${this.apiURL}/import`, formData, {
      headers: headers,
    });
  }

  registerView(): Observable<any> {
    return this.http.get<any>(`${this.apiURL}/registerView`);
  }

  sedEmail_register(formData: FormData): Observable<FormData> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${this.getToken()}`,
    });
    return this.http.post<FormData>(
      `${this.apiURL}/sendEmail/register`,
      formData,
      {
        headers: headers,
      }
    );
  }

  registerUser(token: string, any: any): Observable<any> {
    const headers = new HttpHeaders({
      Authorization: `Bearer ${token}`,
    });
    return this.http.post<any>(`${this.apiURL}/ActivateUser`, any, {
      headers: headers,
    });
  }

  loginUsuario(usuario: Usuario): Observable<Usuario> {
    return this.http.post<Usuario>(`${this.apiURL}/auth`, usuario);
  }

  loggedIn() {
    return !!localStorage.getItem('token');
  }

  logout() {
    this.removeLocalItems();
    this.router.navigate(['/login']);
  }

  removeLocalItems() {
    localStorage.clear();
  }

  getToken() {
    return localStorage.getItem('token');
  }

  getRol() {
    let idRol = '';

    if (this.loggedIn()) {
      let token = this.getToken();
      const decodeToken = this.helper.decodeToken(token!);
      idRol = decodeToken.role;
    } else {
      this.router.navigate(['/']);
    }

    return idRol;
  }

  getRolName() {
    let rolName = '';

    if (this.loggedIn()) {
      let token = this.getToken();
      const decodeToken = this.helper.decodeToken(token!);
      rolName = decodeToken.rol;
    } else {
      this.router.navigate(['/']);
    }

    return rolName;
  }

  getIdUsuario() {
    let idUsuario = '';

    if (this.loggedIn()) {
      let token = this.getToken();
      const decodeToken = this.helper.decodeToken(token!);
      idUsuario = decodeToken.id;
    } else {
      this.router.navigate(['/']);
    }

    return idUsuario;
  }

  getUserName() {
    let nombre = '';

    if (this.loggedIn()) {
      if (localStorage.getItem('userName')) {
        nombre = localStorage.getItem('userName')!;
      } else {
        let token = this.getToken();
        const decodeToken = this.helper.decodeToken(token!);
        nombre = decodeToken.nombre;
      }
    } else {
      this.router.navigate(['/']);
    }

    return nombre;
  }

  getUserFoto() {
    let foto = '';

    if (this.loggedIn()) {
      let token = this.getToken();
      const decodeToken = this.helper.decodeToken(token!);
      foto = decodeToken.foto;
    } else {
      this.router.navigate(['/']);
    }

    return foto;
  }

  getUserCorreo() {
    let correo = '';

    if (this.loggedIn()) {
      let token = this.getToken();
      const decodeToken = this.helper.decodeToken(token!);
      correo = decodeToken.correo;
    } else {
      this.router.navigate(['/']);
    }

    return correo;
  }

  stopTimer() {
    clearTimeout(this.timeoutId);
  }

  resetTimer() {
    clearTimeout(this.timeoutId);
    this.timeoutId = window.setTimeout(() => {
      if (this.loggedIn()) {
        console.log('Cerrando sesion por inactividad', new Date());
        this.logout();
      }
    }, this.tiempoDeInactividad);
  }

  startWatching() {
    //console.log('Start');
    this.resetTimer();
    document.addEventListener('mousemove', () => this.resetTimer());
    document.addEventListener('keydown', () => this.resetTimer());
  }

  clearWatching() {
    //console.log('Stop');
    clearTimeout(this.timeoutId);
  }
}
