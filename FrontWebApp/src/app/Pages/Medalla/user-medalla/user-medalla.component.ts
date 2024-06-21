import { AfterViewInit, Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Medalla } from 'src/app/Models/Medalla';
import {
  AlertError,
  ChangeRoute,
  GetImage,
  Loading,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { MedallaService } from 'src/app/services/medalla.service';

@Component({
  selector: 'app-user-medalla',
  templateUrl: './user-medalla.component.html',
  styleUrls: ['./user-medalla.component.css'],
})
export class UserMedallaComponent implements OnInit, AfterViewInit {
  getImage = GetImage();
  alertError = AlertError();
  loading = Loading();
  changeRoute = ChangeRoute();

  medallas: Medalla[] = [];

  constructor(
    private medallaServicio: MedallaService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.loading(true, false);
  }

  ngAfterViewInit(): void {
    this.cargarData();
  }

  cargarData() {
    this.medallaServicio.getListByUsuario().subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.medallas = lista;
        } else {
          this.alertError(TitleErrorForm, info);
        }
        this.loading(false, false);
      },
      error: (e) => {
        console.error(e);
        if (e.status === 401 || e.status === 403) {
          this.router.navigate(['/']);
        } else {
          this.changeRoute('/404', {});
        }
      },
    });
  }
}
