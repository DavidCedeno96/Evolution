import { AfterViewInit, Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Medalla } from 'src/app/Models/Medalla';
import { Nivel } from 'src/app/Models/Nivel';
import { Recompensa } from 'src/app/Models/Recompensa';
import { Usuario_Reto } from 'src/app/Models/Reto';
import { Usuario } from 'src/app/Models/Usuario';
import { ChangeRoute, GetImage, Loading } from 'src/app/Utils/Constants';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-red-social-perfil',
  templateUrl: './red-social-perfil.component.html',
  styleUrls: ['./red-social-perfil.component.css'],
})
export class RedSocialPerfilComponent implements OnInit, AfterViewInit {
  getImage = GetImage();
  loading = Loading();
  changeRoute = ChangeRoute();

  usuario: Usuario = {
    idUsuario: '',
    nombre: '',
    apellido: '',
    correo: '',
    id: '',
    paisCode: '',
    paisIso2: '',
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

  constructor(private router: Router, private usuarioService: UsuarioService) {}

  ngOnInit(): void {
    this.loading(true, false);
  }

  ngAfterViewInit(): void {
    if (this.usuarioService.loggedIn()) {
      let idUsuario = this.usuarioService.getIdUsuario();
      this.cargarData(idUsuario);
    }
  }

  cargarData(idUsuario: string) {
    this.usuarioService.getLogros(idUsuario).subscribe({
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
          this.changeRoute('/404', {});
        }
      },
    });
  }
}
