import { Component, OnInit } from '@angular/core';
import { Router, NavigationEnd } from '@angular/router';
import { filter } from 'rxjs/operators';
import { UsuarioService } from './services/usuario.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
})
export class AppComponent implements OnInit {
  showNavbarFooter: boolean = false;
  showSpaceBlank: boolean = false;
  url: string = '';

  idRol: string = '';

  constructor(private router: Router, private usuarioServicio: UsuarioService) {
    this.router.events
      .pipe(filter((event) => event instanceof NavigationEnd))
      .subscribe({
        next: (data: any) => {
          this.url = data.url;

          if (this.url === '/') {
            this.router.navigate(['/login']);
          }

          if (this.url.includes('/login') || this.url.includes('/register')) {
            this.showNavbarFooter = false;
          } else {
            this.showNavbarFooter = true;
          }
          if (this.url.includes('/login')) {
            this.showSpaceBlank = false;
          } else {
            this.showSpaceBlank = true;
          }
        },
      });
  }

  ngOnInit(): void {
    if (this.usuarioServicio.loggedIn()) {
      this.usuarioServicio.startWatching();
    }
  }

  menuItemActive(urls: string): string {
    if (this.usuarioServicio.loggedIn()) {
      this.idRol = this.usuarioServicio.getRol();
    }

    let listUrls: string[] = urls.split(',');
    let active: string = '';

    listUrls.forEach((item) => {
      if (item === this.url) {
        active = 'active';
      }
    });
    return active;
  }

  getUrlByRol(adminUrl: string, userUrl: string): string {
    switch (this.idRol) {
      case 'adm': {
        return adminUrl;
      }
      case 'jug': {
        return userUrl;
      }
      default: {
        return '/';
      }
    }
  }

  cerrarSesion() {
    console.log('Cerrando session... redirigiendo al login');
    this.router.navigate(['/']);
  }
}
