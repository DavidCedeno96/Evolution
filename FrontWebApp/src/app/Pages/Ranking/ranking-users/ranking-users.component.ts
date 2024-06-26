import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { Area, Ciudad } from 'src/app/Models/Adicional';
import { Usuario_Reto } from 'src/app/Models/Reto';
import {
  AlertError,
  ChangeRoute,
  GetImage,
  Loading,
  SinRegistros,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { AdicionalService } from 'src/app/services/adicional.service';
import { RetoService } from 'src/app/services/reto.service';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-ranking-users',
  templateUrl: './ranking-users.component.html',
  styleUrls: ['./ranking-users.component.css'],
})
export class RankingUsersComponent implements OnInit {
  alertError = AlertError();
  loading = Loading();
  getImage = GetImage();
  changeRoute = ChangeRoute();

  info: string = SinRegistros;

  idUsuario: string = '';
  usuariosRanking: Usuario_Reto[] = [];
  auxUsuariosRanking: Usuario_Reto[] = [];

  ciudad: Ciudad[] = [];
  area: Area[] = [];

  formulario!: FormGroup;

  constructor(
    private adicionalServicio: AdicionalService,
    private retoServicio: RetoService,
    private usuarioService: UsuarioService,
    private router: Router,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      idCiudad: [''],
      idArea: [''],
    });
  }

  ngOnInit(): void {
    this.loading(true, false);
    this.idUsuario = this.usuarioService.getIdUsuario();
    this.getData();
  }

  getData() {
    this.retoServicio.getRanking(50).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.usuariosRanking = lista;
          this.auxUsuariosRanking = lista;

          this.cargarAdicionales();
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

  cargarAdicionales() {
    this.adicionalServicio.getListUsuario(1).subscribe({
      next: (data: any) => {
        let { ciudadList, areaList } = data.response;
        this.ciudad = ciudadList.lista;
        this.area = areaList.lista;
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

  filtrar() {
    let idArea: string = this.formulario.get(['idArea'])?.value;
    let idCiudad: string = this.formulario.get(['idCiudad'])?.value;
    let lista: Usuario_Reto[] = [];

    if (idArea && idCiudad) {
      lista = this.auxUsuariosRanking.filter((item) => {
        return (
          item.usuario.idArea === idArea && item.usuario.idCiudad === idCiudad
        );
      });
    } else if (idArea) {
      lista = this.auxUsuariosRanking.filter((item) => {
        return item.usuario.idArea === idArea;
      });
    } else if (idCiudad) {
      lista = this.auxUsuariosRanking.filter((item) => {
        return item.usuario.idCiudad === idCiudad;
      });
    }

    if (idArea || idCiudad) {
      this.usuariosRanking = lista;
    } else {
      this.usuariosRanking = this.auxUsuariosRanking;
    }

    if (!lista.length) {
      this.info = 'No se encontró ningún resultado';
    } else {
      this.info = SinRegistros;
    }
  }

  getUserNamePodio(posicion: number): string {
    let userName: string = '';

    this.auxUsuariosRanking.forEach((item) => {
      if (item.posicion === posicion) {
        userName = item.usuario.nombre;
      }
    });

    return userName;
  }

  getUserFotoPodio(posicion: number): string {
    let userFoto: string = '';

    this.auxUsuariosRanking.forEach((item) => {
      if (item.posicion === posicion) {
        userFoto = item.usuario.foto;
      }
    });

    return userFoto;
  }
}
