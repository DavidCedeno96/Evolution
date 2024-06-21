import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Usuario_Reto } from 'src/app/Models/Reto';
import {
  AlertError,
  ChangeRoute,
  GetImage,
  Loading,
  SinRegistros,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { RetoService } from 'src/app/services/reto.service';

@Component({
  selector: 'app-validaciones',
  templateUrl: './validaciones.component.html',
  styleUrls: ['./validaciones.component.css'],
})
export class ValidacionesComponent implements OnInit {
  load = Loading();
  alertError = AlertError();
  getImage = GetImage();
  changeRoute = ChangeRoute();

  first: number = 0;
  rows: number = 9; // items por página

  ur: Usuario_Reto[] = [];

  info: string = '';

  constructor(private router: Router, private retoServicio: RetoService) {}

  ngOnInit(): void {
    this.load(true, false);
    this.cargarData();
  }

  cargarData() {
    this.retoServicio.getRetosXValidar(-1).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.ur = lista;
          this.info = SinRegistros;
        } else {
          this.alertError(TitleErrorForm, info);
        }
        this.load(false, false);
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

  selectReto(ur: Usuario_Reto) {
    this.changeRoute('/validaciones/users', { reto: ur.reto.idReto });
  }

  paginatedItems(): Usuario_Reto[] {
    const startIndex = this.first;
    const endIndex = startIndex + this.rows;
    return this.ur.slice(startIndex, endIndex);
  }

  totalItems(): number {
    return this.ur.length;
  }

  onPageChange(event: any) {
    this.first = event.first;
    this.rows = event.rows;
  }
}
