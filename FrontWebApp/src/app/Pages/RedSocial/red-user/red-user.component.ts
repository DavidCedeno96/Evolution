import { AfterViewInit, Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Medalla } from 'src/app/Models/Medalla';
import { Nivel } from 'src/app/Models/Nivel';
import { Recompensa } from 'src/app/Models/Recompensa';
import { Usuario_Reto } from 'src/app/Models/Reto';
import { Usuario } from 'src/app/Models/Usuario';
import { GetImage, Loading } from 'src/app/Utils/Constants';
import { RedSocialService } from 'src/app/services/red-social.service';

@Component({
  selector: 'app-red-user',
  templateUrl: './red-user.component.html',
  styleUrls: ['./red-user.component.css'],
})
export class RedUserComponent implements OnInit, AfterViewInit {
  getImage = GetImage();
  loading = Loading();

  idRed: string = '';

  usuario: Usuario = {
    idUsuario: '',
    nombre: '',
    apellido: '',
    correo: '',
    id: '',
    celular: '',
    foto: '',
    idRol: '',
    rol: '',
    idPais: '',
    pais: '',
    idCiudad: '',
    ciudad: '',
    idEmpresa: '',
    empresa: '',
    idArea: '',
    area: '',
    contrasena: '',
    puntos: 0,
    creditos: 0,
    estado: 0,
  };

  miNivel: Nivel[] = [];
  nivelProx: Nivel = {
    idNivel: '',
    nombre: '',
    descripcion: '',
    puntosNecesarios: 100,
    imagen: '',
    totalUsuarios: 0,
    estado: 0,
    fechaCreacion: new Date(),
  };
  tieneNivelProx: boolean = false;
  porcentajeNivel: number = 0;

  misRetosTerminados: Usuario_Reto[] = [];
  misMedallas: Medalla[] = [];
  recompensas: Recompensa[] = [];

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private redSocialService: RedSocialService
  ) {}

  ngOnInit(): void {
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    this.loading(true, false);
    this.cargarData();
  }

  getRouteParams() {
    this.route.queryParams.subscribe((params) => {
      this.idRed = params['red'];
      if (this.idRed === '') {
        history.back();
      }
    });
  }

  cargarData() {
    this.redSocialService.getListUser(this.idRed).subscribe({
      next: (data: any) => {
        let { error, lista } = data.response;
        if (error === 0) {
          this.usuario = lista[0];
          this.miNivel = lista[1];
          if (lista[2]) {
            this.nivelProx = lista[2];
            this.tieneNivelProx = true;
          }
          this.porcentajeNivel = lista[3];
          this.misMedallas = lista[4];
          this.misRetosTerminados = lista[5];
          this.recompensas = lista[6];
        } else {
          history.back();
        }
        this.loading(false, false);
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
