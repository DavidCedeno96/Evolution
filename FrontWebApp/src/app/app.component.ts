import { AfterViewInit, Component, ElementRef, OnInit } from '@angular/core';
import { Router, NavigationEnd } from '@angular/router';
import { filter } from 'rxjs/operators';
import { UsuarioService } from './services/usuario.service';
import { ConfiguracionService } from './services/configuracion.service';
import {
  AlertError,
  MsgErrorConexion,
  TitleError,
  TitleErrorForm,
} from './Utils/Constants';
import { Configuracion } from './Models/Configuracion';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
})
export class AppComponent implements OnInit, AfterViewInit {
  alertError = AlertError();

  load: boolean = false;
  showNavbarFooter: boolean = false;
  showSpaceBlank: boolean = false;
  url: string = '';

  idRol: string = '';

  //configuraciones: Configuracion[] = [];

  constructor(
    private router: Router,
    private el: ElementRef,
    private usuarioServicio: UsuarioService,
    private configuracionService: ConfiguracionService
  ) {
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
    this.auxLoad(true);
    this.cargarConfig();

    if (this.usuarioServicio.loggedIn()) {
      this.usuarioServicio.startWatching();
    }
  }

  ngAfterViewInit(): void {}

  cargarConfig() {
    let hostElement = this.el.nativeElement;
    this.configuracionService.getList().subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          //this.configuraciones = lista;
          //console.log(lista);
          lista.forEach((item: Configuracion) => {
            if (item.tipo === 'color') {
              hostElement.style.setProperty(item.propiedad, item.valor);
            }
          });
        } else {
          this.alertError(TitleErrorForm, info);
        }
        this.auxLoad(false);
      },
      error: (e) => {
        console.error(e);
        this.alertError(TitleError, MsgErrorConexion);
      },
    });
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
    this.auxLoad(true);
    console.log('cerrando session...');
    this.router.navigate(['/']);
  }

  auxLoad(visible: boolean) {
    if (visible) {
      this.load = true;
    }
    setTimeout(() => {
      this.load = false;
    }, 400);
  }
}
