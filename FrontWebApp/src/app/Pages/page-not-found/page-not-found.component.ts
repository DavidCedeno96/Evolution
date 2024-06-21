import { AfterViewInit, Component } from '@angular/core';
import { ChangeRoute, Loading } from 'src/app/Utils/Constants';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-page-not-found',
  templateUrl: './page-not-found.component.html',
  styleUrls: ['./page-not-found.component.css'],
})
export class PageNotFoundComponent implements AfterViewInit {
  changeRoute = ChangeRoute();
  loading = Loading();

  constructor(private usuarioServicio: UsuarioService) {}

  ngAfterViewInit(): void {
    this.loading(false, false);
    this.usuarioServicio.startWatching();
  }

  goLoginOrGoingHome() {
    if (this.usuarioServicio.loggedIn()) {
      this.changeRoute('/home', {});
    } else {
      this.changeRoute('/login', {});
    }
  }
}
