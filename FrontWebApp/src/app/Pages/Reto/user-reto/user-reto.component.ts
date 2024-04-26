import { Component, ElementRef, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { Reto, Usuario_Reto } from 'src/app/Models/Reto';
import {
  AlertError,
  AlertWarning,
  ChangeRoute,
  DateCompare,
  GetImage,
  Loading,
  MsgError,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { RetoService } from 'src/app/services/reto.service';

@Component({
  selector: 'app-user-reto',
  templateUrl: './user-reto.component.html',
  styleUrls: ['./user-reto.component.css'],
})
export class UserRetoComponent implements OnInit {
  changeRoute = ChangeRoute();
  alertError = AlertError();
  alertWarning = AlertWarning();
  getImage = GetImage();
  dateCompare = DateCompare();
  load = Loading();

  customOuterStrokeColor: string = '';

  first: number = 0;
  rows: number = 9; // items por página

  info: string = '';

  formulario!: FormGroup;

  ur: Usuario_Reto[] = [];
  auxUr: Usuario_Reto[] = [];

  constructor(
    private el: ElementRef,
    private router: Router,
    private retoService: RetoService,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      buscar: [''],
    });
  }

  ngOnInit(): void {
    this.load(true, false);
    this.getPrimaryColor();
    this.cargarData();
  }

  cargarData() {
    this.retoService.getUsuario_RetoByIdUsuario().subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.ur = lista;
          this.auxUr = lista;
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
          this.load(false, false);
          this.alertError(TitleError, MsgError);
        }
      },
    });
  }

  submitBuscar() {
    let buscar = this.formulario.get(['buscar'])?.value;
    if (buscar.trim() !== '') {
      this.load(true, false);
      this.getBuscar(buscar);
    } else {
      this.ur = this.auxUr;
    }
  }

  getBuscar(texto: string) {
    this.retoService.getBuscarUsuario_RetoByIdUsuario(texto).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.ur = lista;
        } else {
          this.ur = [];
          this.info = info;
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

  defaultList(event: Event) {
    let text = (event.target as HTMLInputElement).value;
    if (!text.trim()) {
      this.ur = this.auxUr;
    }
  }

  entrarReto(ur: Usuario_Reto) {
    let fechaHoy = new Date();
    fechaHoy.setHours(0, 0, 0, 0);

    let fechaAValida = true;
    let fechaCValida = true;

    if (
      new Date(ur.reto.fechaApertura) >= fechaHoy &&
      this.dateCompare(ur.reto.fechaApertura) !== 'N/A'
    ) {
      fechaAValida = false;
    }

    if (
      new Date(ur.reto.fechaCierre) < fechaHoy &&
      this.dateCompare(ur.reto.fechaCierre) !== 'N/A'
    ) {
      fechaCValida = false;
    }

    if (ur.completado === 1) {
      this.changeRoute('/fin-reto', { reto: ur.reto.idReto });
    } else if (!ur.reto.estado) {
      this.alertWarning('', 'El reto está desactivado');
    } else if (!fechaAValida) {
      this.alertWarning(
        '',
        'El reto se encuentra cerrado hasta que se cumpla la fecha de inicio'
      );
    } else if (!fechaCValida) {
      this.alertWarning('', 'El reto ha caducado');
    } else {
      this.changeRoute('/entrada-reto', { reto: ur.reto.idReto });
    }
  }

  getEstadoFecha(reto: Reto): number {
    let fechaHoy = new Date();
    fechaHoy.setHours(0, 0, 0, 0);

    if (
      (new Date(reto.fechaApertura) >= fechaHoy &&
        this.dateCompare(reto.fechaApertura) !== 'N/A') ||
      (new Date(reto.fechaCierre) < fechaHoy &&
        this.dateCompare(reto.fechaCierre) !== 'N/A')
    ) {
      return 0;
    } else {
      return 1;
    }
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

  getPrimaryColor() {
    this.customOuterStrokeColor = window
      .getComputedStyle(this.el.nativeElement)
      .getPropertyValue('--Primario');
  }
}
