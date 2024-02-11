import {
  AfterContentInit,
  Component,
  ElementRef,
  OnInit,
  Renderer2,
} from '@angular/core';
import { Router, NavigationEnd } from '@angular/router';
import { filter } from 'rxjs/operators';
import { UsuarioService } from './services/usuario.service';
import { ConfiguracionService } from './services/configuracion.service';
import {
  AlertError,
  GetImage,
  ImgSizeMax,
  MsgError,
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
export class AppComponent implements OnInit, AfterContentInit {
  alertError = AlertError();
  getImage = GetImage();

  load: boolean = false;
  showNavbar: boolean = false;
  url: string = '';

  userName: string = '';
  userFoto: string = '';
  idRol: string = '';
  previewFoto: string = '';

  imgLogin: string = '';
  imgHeader: string = '';
  imgFooter: string = '';

  constructor(
    private router: Router,
    private renderer: Renderer2,
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
            this.showNavbar = false;
          } else {
            this.showNavbar = true;
            if (usuarioServicio.loggedIn()) {
              this.idRol = this.usuarioServicio.getRol();
              this.userName = this.usuarioServicio.getUserName();
              this.userFoto = this.usuarioServicio.getUserFoto();
            }
          }

          if (localStorage.getItem('foto')) {
            this.userFoto = localStorage.getItem('foto')!;
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

  ngAfterContentInit(): void {}

  cargarConfig() {
    let hostElement = this.el.nativeElement;
    this.configuracionService.getList().subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          lista.forEach((item: Configuracion) => {
            if (item.tipo === 'color') {
              hostElement.style.setProperty(item.propiedad, item.valor);
            }
          });

          let imagenes: Configuracion[] = lista.filter(
            (item: Configuracion) => {
              return item.tipo === 'imagen';
            }
          );

          this.imgLogin = imagenes[0].valor;
          this.imgHeader = imagenes[1].valor;
          this.imgFooter = imagenes[2].valor;

          this.setImageLogin();
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
        return '/login';
      }
    }
  }

  onFileSelected(event: Event) {
    let selectedImage = (event.target as HTMLInputElement).files![0];

    if (selectedImage.size > ImgSizeMax) {
      this.alertError(
        TitleErrorForm,
        'El tamaño del archivo no puede superar los 600 KB.'
      );
    } else {
      if (selectedImage.size > 0) {
        let reader = new FileReader();
        reader.onload = (e: any) => {
          this.previewFoto = e.target.result;
        };
        reader.readAsDataURL(selectedImage);
        this.load = true;
        this.cambiarFotoUser(selectedImage);
      }
    }
    console.log(selectedImage.name, this.previewFoto);
  }

  cambiarFotoUser(foto: File) {
    let formData = new FormData();
    if (foto) {
      formData.append('archivo', foto);
    }
    this.usuarioServicio.updateByFoto(formData).subscribe({
      next: (data: any) => {
        let { error, info } = data.response;
        if (error === 0) {
          localStorage.setItem('foto', foto.name);
        } else {
          this.alertError(TitleErrorForm, info); //MsgErrorForm
          localStorage.removeItem('foto');
        }
        this.load = false;
      },
      error: (e) => {
        console.error(e);
        if (e.status === 401 || e.status === 403) {
          this.router.navigate(['/']);
        } else {
          this.alertError(TitleError, MsgError);
          this.load = false;
        }
      },
    });
  }

  setImageLogin() {
    const fondo = this.el.nativeElement.querySelector('.fondoImagen');
    if (fondo) {
      this.renderer.setStyle(
        fondo,
        'background-image',
        `url("${this.getImage(this.imgLogin, 'config', 'default-login.png')}")`
      );
      /* `url("assets/img/default/${this.imgFondo}")` */
    }
  }

  auxLoad(visible: boolean) {
    if (visible) {
      this.load = true;
    }
    setTimeout(() => {
      this.load = false;
    }, 400);
  }

  cerrarSesion() {
    this.load = true;
    console.log('cerrando session...');
    this.usuarioServicio.logout();
  }
}
