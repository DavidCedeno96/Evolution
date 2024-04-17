import { AfterViewInit, Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Nivel } from 'src/app/Models/Nivel';
import {
  AlertError,
  DateCompare,
  GetImage,
  Loading,
  MsgError,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { NivelService } from 'src/app/services/nivel.service';

@Component({
  selector: 'app-user-nivel',
  templateUrl: './user-nivel.component.html',
  styleUrls: ['./user-nivel.component.css'],
})
export class UserNivelComponent implements OnInit, AfterViewInit {
  getImage = GetImage();
  alertError = AlertError();
  loading = Loading();
  dateCompare = DateCompare();

  niveles: Nivel[] = [];

  constructor(private nivelService: NivelService, private router: Router) {}

  ngOnInit(): void {
    this.loading(true, false);
  }

  ngAfterViewInit(): void {
    this.cargarData();
  }

  cargarData() {
    this.nivelService.getListByUsuario().subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.niveles = lista;
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
          this.alertError(TitleError, MsgError);
          this.loading(false, false);
        }
      },
    });
  }
}
