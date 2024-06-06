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
  ChangeRoute,
  GetImage,
  ImgHeightMax,
  ImgSizeMax,
  ImgWidthMax,
  MsgError,
  MsgErrorConexion,
  TitleError,
  TitleErrorForm,
} from './Utils/Constants';
import { Configuracion } from './Models/Configuracion';
import { GetBreadcrumb, GetNavItemPills } from './Utils/DefaultLists';
import { Links } from './Models/Links';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
})
export class AppComponent implements OnInit, AfterContentInit {
  alertError = AlertError();
  getImage = GetImage();
  getBreadcrumb = GetBreadcrumb();
  getNavItemPills = GetNavItemPills();
  changeRoute = ChangeRoute();

  load: boolean = false;
  showNavbar: boolean = false;
  breadcrumbList: Links[] = [];
  pillsList: Links[] = [];
  subMenu: number = 0;
  activeSubMenu: boolean = false;
  url: string = '';

  userName: string = '';
  userFoto: string = '';
  idRol: string = '';
  rolName: string = '';
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

          this.breadcrumbList = this.getBreadcrumb(this.url, this.idRol);
          this.pillsList = this.getNavItemPills(this.url);

          if (this.url === '/') {
            this.router.navigate(['/login']);
          }

          if (
            this.url.includes('/login') ||
            this.url.includes('/register') ||
            this.url.includes('/activate-user')
          ) {
            this.showNavbar = false;
          } else {
            this.showNavbar = true;
            if (usuarioServicio.loggedIn()) {
              this.idRol = this.usuarioServicio.getRol();
              this.rolName = this.usuarioServicio.getRolName();
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

          this.changeFavicon(
            this.getImage(imagenes[2].valor, 'Config', 'default-logoD.png')
          );
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

  setItemActive(urls: string): string {
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

    if (selectedImage) {
      let reader = new FileReader();
      reader.onload = (e: any) => {
        let img = new Image();
        img.src = e.target.result;
        img.onload = () => {
          let w = (img as HTMLImageElement).width;
          let h = (img as HTMLImageElement).height;

          if (
            selectedImage.size > ImgSizeMax ||
            w > ImgWidthMax ||
            h > ImgHeightMax
          ) {
            this.alertError(
              TitleErrorForm,
              'El tamaño del archivo no puede superar los 200 KB.'
            );
          } else {
            this.previewFoto = img.src;

            this.load = true;
            setTimeout(() => {
              this.cambiarFotoUser(selectedImage);
            }, 600);
          }
        };
      };
      reader.readAsDataURL(selectedImage);
    }
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
          if (this.url.includes('/profile-user')) {
            this.router.navigate(['/home']);
          } else {
            this.load = false;
          }
        } else {
          this.alertError(TitleErrorForm, info); //MsgErrorForm
          localStorage.removeItem('foto');
          this.load = false;
        }
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

  /* openSumMenu(item: number) {
    if (this.subMenu !== item) {
      this.subMenu = item;
      this.activeSubMenu = true;
    } else {
      this.activeSubMenu = !this.activeSubMenu;
    }
  } */

  changeFavicon(url: string) {
    const link = document.createElement('link');
    link.rel = 'icon';
    link.type = 'image/png';
    link.href = url;
    document.head.appendChild(link);
  }

  getSingleUrl(): string {
    return this.url.split('?')[0];
  }

  getIsUrl(url: string): boolean {
    if (this.url.includes(url)) {
      return true;
    } else {
      return false;
    }
  }

  back() {
    history.back();
  }

  cerrarSesion() {
    this.load = true;
    console.log('cerrando session...');
    this.usuarioServicio.logout();
  }
}
