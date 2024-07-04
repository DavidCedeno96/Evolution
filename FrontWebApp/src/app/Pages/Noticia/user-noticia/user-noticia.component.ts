import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import {
  Noticia_Reaccion,
  Reaccion,
  Usuario_Noticia,
} from 'src/app/Models/Noticia';
import {
  AlertError,
  ChangeRoute,
  GetImage,
  Loading,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { exp_invalidos } from 'src/app/Utils/RegularExpressions';
import { NoticiaService } from 'src/app/services/noticia.service';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-user-noticia',
  templateUrl: './user-noticia.component.html',
  styleUrls: ['./user-noticia.component.css'],
})
export class UserNoticiaComponent implements OnInit, AfterViewInit {
  alertError = AlertError();
  loading = Loading();
  getImage = GetImage();
  changeRoute = ChangeRoute();

  noticia: string = '';

  idUsuario: string = '';
  verErrorsInputs: boolean = false;

  textTruncated: boolean[] = [];

  formulario!: FormGroup;
  noticia_reaccion: Noticia_Reaccion[] = [];

  constructor(
    private route: ActivatedRoute,
    private noticiaService: NoticiaService,
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
    this.idUsuario = this.usuarioService.getIdUsuario();
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    this.cargarData();
  }

  getRouteParams() {
    this.route.queryParams.subscribe((params) => {
      let idNoticia = params['noticia'];
      if (idNoticia !== '' && params['noticia']) {
        this.noticia = `?idNoticia=${idNoticia}`;
      }
    });
  }

  cargarData() {
    this.noticiaService.getListAndComents(-1, this.noticia).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.noticia_reaccion = lista;
          this.textTruncated = new Array(lista.length).fill(true);
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

  addReaccion(tipo: string, noticia: Noticia_Reaccion) {
    if (tipo === 'comentario') {
      if (this.formulario.valid) {
        this.loading(true, false);
        this.verErrorsInputs = false;
        //console.log('GUARDANDO ......');
        let comentario = this.formulario.get(['comentario'])?.value;
        this.guardarReaccion(0, comentario, noticia.noticia.idNoticia);
        this.formulario.patchValue({
          comentario: '',
        });
      } else {
        this.verErrorsInputs = true;
      }
    } else if (tipo == 'like') {
      this.loading(true, false);
      let dioLike = false;
      noticia.comentarioList.forEach((item) => {
        if (item.idUsuario == this.idUsuario && item.likes > 0) {
          dioLike = true;
        }
      });

      if (dioLike) {
        this.guardarReaccion(-1, '', noticia.noticia.idNoticia);
      } else {
        this.guardarReaccion(1, '', noticia.noticia.idNoticia);
      }
    }
  }

  guardarReaccion(likes: number, comentario: string, idNoticia: string) {
    let noticia: Usuario_Noticia = {
      idUsuario: this.idUsuario,
      idNoticia: idNoticia,
      likes: likes,
      comentario: comentario,
    };
    this.noticiaService.createReaccion(noticia).subscribe({
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

  getComentarios(lista: Noticia_Reaccion): Reaccion[] {
    let auxList: Reaccion[] = [];

    auxList = lista.comentarioList.filter((item) => item.comentario.trim());

    return auxList;
  }

  onNavigate(url: string) {
    let protocolo = 'https://';
    if (url.includes(protocolo)) {
      window.open(url, '_blank');
    } else {
      window.open(protocolo + url, '_blank');
    }
  }

  truncate(text: string, index: number) {
    if (text.length > 180) {
      this.textTruncated[index] = !this.textTruncated[index];
    }
  }
}
