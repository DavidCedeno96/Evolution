import { AfterViewInit, Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Usuario_Equipo } from 'src/app/Models/Equipo';
import {
  AlertError,
  ChangeRoute,
  GetImage,
  Loading,
  MsgError,
  SinRegistros,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { EquipoService } from 'src/app/services/equipo.service';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-ranking-teams',
  templateUrl: './ranking-teams.component.html',
  styleUrls: ['./ranking-teams.component.css'],
})
export class RankingTeamsComponent implements OnInit, AfterViewInit {
  alertError = AlertError();
  loading = Loading();
  getImage = GetImage();
  changeRoute = ChangeRoute();

  idUsuario: string = '';
  idEquipo: string = '';

  info: string = SinRegistros;

  usuariosEquipos: Usuario_Equipo[] = [];

  constructor(
    private equipoServicio: EquipoService,
    private usuarioService: UsuarioService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.loading(true, false);
    this.idUsuario = this.usuarioService.getIdUsuario();
  }

  ngAfterViewInit(): void {
    this.getData();
  }

  getData() {
    this.equipoServicio.getRanking(this.idUsuario, 50).subscribe({
      next: (data: any) => {
        let { error, info, lista, id } = data.response;
        if (error === 0) {
          this.idEquipo = id;
          this.usuariosEquipos = lista;
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

  getTeamNamePodio(posicion: number): string {
    let teamName: string = '';

    this.usuariosEquipos.forEach((item) => {
      if (item.posicion === posicion) {
        teamName = item.equipo.nombre;
      }
    });

    return teamName;
  }

  getTeamImgPodio(posicion: number): string {
    let teamFoto: string = '';

    this.usuariosEquipos.forEach((item) => {
      if (item.posicion === posicion) {
        teamFoto = item.equipo.imagen;
      }
    });

    return teamFoto;
  }
}
