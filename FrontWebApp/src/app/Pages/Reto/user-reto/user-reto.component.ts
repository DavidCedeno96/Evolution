import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { Reto } from 'src/app/Models/Reto';
import {
  AlertError,
  ChangeRoute,
  DateFormat,
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
  getImage = GetImage();
  dateFormat = DateFormat();
  load = Loading();

  first: number = 0;
  rows: number = 9; // items por página

  info: string = '';

  formulario!: FormGroup;

  auxRetos: Reto[] = [];
  retos: Reto[] = [
    {
      idReto: '',
      nombre: '',
      fechaApertura: new Date(),
      fechaCierre: new Date(),
      vidas: 0,
      tiempo_ms: 0,
      puntosRecompensa: 0,
      creditosObtenidos: 0,
      instrucciones: '',
      imagen: '',
      idTipoReto: '',
      tipoReto: '',
      idComportamiento: '',
      comportamiento: '',
      estado: 0,
    },
  ];

  constructor(
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
    this.cargarData();
  }

  cargarData() {
    this.retoService.getList(-1).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          lista.forEach((item: Reto) => {
            if (new Date(item.fechaCierre) < new Date()) {
              item.estado = 0;
            }
          });
          this.retos = lista;
          this.auxRetos = lista;
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
      this.retos = this.auxRetos;
    }
  }

  getBuscar(texto: string) {
    this.retoService.getBuscarList(texto).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.retos = lista;
        } else {
          this.retos = [];
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
    if (!text) {
      this.retos = this.auxRetos;
    }
  }

  entrarReto(idReto: string, estado: number) {
    if (estado) {
      this.changeRoute('/entrada-reto', { reto: idReto });
    } else {
      this.alertError(TitleErrorForm, 'El reto esta desactivado');
    }
  }

  paginatedItems(): Reto[] {
    const startIndex = this.first;
    const endIndex = startIndex + this.rows;
    return this.retos.slice(startIndex, endIndex);
  }

  totalItems(): number {
    return this.retos.length;
  }

  onPageChange(event: any) {
    this.first = event.first;
    this.rows = event.rows;
  }
}
