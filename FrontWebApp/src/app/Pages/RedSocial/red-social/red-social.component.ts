import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import {
  Reaccion,
  RedSocial_Reaccion,
  Usuario_RedSocial,
} from 'src/app/Models/RedSocial';
import {
  AlertError,
  ChangeRoute,
  GetImage,
  Loading,
  MsgError,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { exp_invalidos } from 'src/app/Utils/RegularExpressions';
import { RedSocialService } from 'src/app/services/red-social.service';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-red-social',
  templateUrl: './red-social.component.html',
  styleUrls: ['./red-social.component.css'],
})
export class RedSocialComponent implements OnInit {
  alertError = AlertError();
  loading = Loading();
  changeRoute = ChangeRoute();
  getImage = GetImage();

  idUsuario: string = '';
  verErrorsInputs: boolean = false;

  userName: string = '';
  userFoto: string = '';

  formulario!: FormGroup;
  redSocial_reaccion: RedSocial_Reaccion[] = [];

  constructor(
    private redSocialService: RedSocialService,
    private usuarioService: UsuarioService,
    private router: Router,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      comentario: [
        '',
        [
          Validators.required,
          Validators.maxLength(250),
          Validators.pattern(exp_invalidos),
        ],
      ],
    });
  }

  ngOnInit(): void {
    this.loading(true, false);
    this.cargarData();
    this.cargarCurrentUser();
  }

  cargarData() {
    this.redSocialService.getListAndComents().subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.redSocial_reaccion = lista;
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

  cargarCurrentUser() {
    if (this.usuarioService.loggedIn()) {
      this.idUsuario = this.usuarioService.getIdUsuario();
      this.userName = this.usuarioService.getUserName();
      this.userFoto = this.usuarioService.getUserFoto();
    }

    if (localStorage.getItem('foto')) {
      this.userFoto = localStorage.getItem('foto')!;
    }

    if (localStorage.getItem('userName')) {
      this.userName = localStorage.getItem('userName')!;
    }
  }

  addReaccion(tipo: string, redSocial: RedSocial_Reaccion) {
    if (tipo === 'comentario') {
      if (this.formulario.valid) {
        this.loading(true, false);
        this.verErrorsInputs = false;
        let comentario = this.formulario.get(['comentario'])?.value;
        this.guardarReaccion(0, comentario, redSocial.redSocial.idRed);
        this.formulario.patchValue({
          comentario: '',
        });
      } else {
        this.verErrorsInputs = true;
      }
    } else if (tipo == 'like') {
      this.loading(true, false);
      let dioLike = false;
      redSocial.comentarioList.forEach((item) => {
        if (item.idUsuario == this.idUsuario && item.likes > 0) {
          dioLike = true;
        }
      });

      if (dioLike) {
        this.guardarReaccion(-1, '', redSocial.redSocial.idRed);
      } else {
        this.guardarReaccion(1, '', redSocial.redSocial.idRed);
      }
    }
  }

  guardarReaccion(likes: number, comentario: string, idRed: string) {
    let redSocial: Usuario_RedSocial = {
      idUsuario: this.idUsuario,
      idRed: idRed,
      likes: likes,
      comentario: comentario,
    };
    this.redSocialService.createReaccion(redSocial).subscribe({
      next: (data: any) => {
        let { error, info } = data.response;
        if (error === 0) {
          this.cargarData();
        } else {
          this.loading(false, false);
          this.alertError(TitleErrorForm, info);
        }
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

  /* getDescription(desc: string, index: number): string {
    return desc.split('|')[index];
  } */

  getComentarios(lista: RedSocial_Reaccion): Reaccion[] {
    let auxList: Reaccion[] = [];

    auxList = lista.comentarioList.filter((item) => item.comentario.trim());

    return auxList;
  }
}
