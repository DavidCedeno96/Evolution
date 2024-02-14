import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Medalla } from 'src/app/Models/Medalla';
import { Nivel } from 'src/app/Models/Nivel';
import { Noticia } from 'src/app/Models/Noticia';
import { Reto } from 'src/app/Models/Reto';
import {
  AlertError,
  DateFormat,
  GetImage,
  Loading,
  MsgError,
  TitleError,
} from 'src/app/Utils/Constants';
import { HomeService } from 'src/app/services/home.service';

@Component({
  selector: 'app-home-user',
  templateUrl: './home-user.component.html',
  styleUrls: ['./home-user.component.css'],
})
export class HomeUserComponent implements OnInit {
  load = Loading();
  alertError = AlertError();
  getImage = GetImage();
  dateFormat = DateFormat();

  retosCompletados: number = 0;
  medallasConseguidas: number = 0;
  recomensasReclamadas: number = 0;

  nivel: Nivel[] = [];
  retos: Reto[] = [];
  noticias: Noticia[] = [];
  medallas: Medalla[] = [];

  constructor(private homeService: HomeService, private router: Router) {}

  ngOnInit(): void {
    this.load(true, false);
    this.cargarData();
  }

  cargarData() {
    this.homeService.getJugadorList().subscribe({
      next: (data: any) => {
        let {
          miNivel,
          misMedallas,
          misRetosTerminados,
          noticiasEnTendencia,
          resumenGeneral,
        } = data;
        if (miNivel.error === 0) {
          this.nivel = miNivel.lista;
        }
        if (misMedallas.error === 0) {
          this.medallas = misMedallas.lista;
        }
        if (misRetosTerminados.error === 0) {
          this.retos = misRetosTerminados.lista;
        }
        if (noticiasEnTendencia.error === 0) {
          this.noticias = noticiasEnTendencia.lista;
        }
        if (resumenGeneral.error === 0) {
          this.retosCompletados =
            resumenGeneral.resumenGeneral.retosCompletados;
          this.medallasConseguidas =
            resumenGeneral.resumenGeneral.medallasConseguidas;
          this.recomensasReclamadas =
            resumenGeneral.resumenGeneral.recomensasReclamadas;
        }
        this.load(false, false);
      },
      error: (e) => {
        console.error(e);
        if (e.status === 401 || e.status === 403) {
          this.router.navigate(['/']);
        } else {
          this.alertError(TitleError, MsgError);
        }
      },
    });
  }
}
