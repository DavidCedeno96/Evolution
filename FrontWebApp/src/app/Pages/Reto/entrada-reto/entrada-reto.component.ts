import { AfterViewInit, Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Reto } from 'src/app/Models/Reto';
import { ChangeRoute, GetImage, Loading } from 'src/app/Utils/Constants';
import { RetoService } from 'src/app/services/reto.service';

@Component({
  selector: 'app-entrada-reto',
  templateUrl: './entrada-reto.component.html',
  styleUrls: ['./entrada-reto.component.css'],
})
export class EntradaRetoComponent implements OnInit, AfterViewInit {
  load = Loading();
  getImage = GetImage();
  changeRoute = ChangeRoute();

  id: string = '';

  reto: Reto = {
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
  };

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private retoService: RetoService
  ) {}

  ngOnInit(): void {
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    this.load(true, false);
    this.cargarData(this.id);
  }

  getRouteParams() {
    this.route.queryParams.subscribe((params) => {
      let idReto = params['reto'];
      if (!params['reto']) {
        history.back();
      }
      this.id = idReto;
    });
  }

  cargarData(idReto: string) {
    this.retoService.getItem(-1, idReto).subscribe({
      next: (data: any) => {
        let { error, reto } = data.response;
        if (error === 0) {
          this.reto = reto;
        } else {
          history.back();
        }
        this.load(false, false);
      },
      error: (e) => {
        console.error(e);
        if (e.status === 401 || e.status === 403) {
          this.router.navigate(['/']);
        } else {
          history.back();
        }
      },
    });
  }
}
