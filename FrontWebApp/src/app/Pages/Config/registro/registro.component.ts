import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { Configuracion } from 'src/app/Models/Configuracion';
import {
  AlertError,
  ChangeRoute,
  Loading,
  MsgError,
  MsgErrorForm,
  MsgOk,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { exp_invalidos, exp_numeros } from 'src/app/Utils/RegularExpressions';
import { ConfiguracionService } from 'src/app/services/configuracion.service';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-registro',
  templateUrl: './registro.component.html',
  styleUrls: ['./registro.component.css'],
  providers: [MessageService],
})
export class RegistroComponent implements OnInit {
  loading = Loading();
  alertError = AlertError();
  changeRoute = ChangeRoute();

  idUsuario: string = '';

  config: Configuracion[] = [];

  formulario!: FormGroup;

  constructor(
    private messageService: MessageService,
    private configuracionService: ConfiguracionService,
    private usuarioService: UsuarioService,
    private router: Router,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      llave: [
        '',
        [
          Validators.required,
          Validators.minLength(5),
          Validators.maxLength(50),
          Validators.pattern(exp_invalidos),
        ],
      ],
      view: [
        '',
        [
          Validators.required,
          Validators.min(0),
          Validators.max(1),
          Validators.pattern(exp_numeros),
        ],
      ],
    });
  }

  ngOnInit(): void {
    this.loading(true, false);
    this.cargarConfig();
  }

  ngAfterViewInit(): void {
    this.idUsuario = this.usuarioService.getIdUsuario();
  }

  cargarConfig() {
    this.configuracionService.getList().subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.config = lista.filter((item: Configuracion) => {
            return item.tipo === 'llave' || item.tipo === 'view';
          });

          let configLlave = this.config.find((item) => item.tipo === 'llave');
          let configView = this.config.find((item) => item.tipo === 'view');

          this.formulario.patchValue({
            llave: configLlave?.valor,
            view: Number(configView?.valor),
          });

          this.loading(false, false);
        } else {
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

  update() {
    if (this.formulario.valid) {
      this.loading(true, false);
      this.configuracionService.updateList(this.setData()).subscribe({
        next: (data: any) => {
          let { info, error } = data.response;
          if (error === 0) {
            this.messageService.add({
              severity: 'success',
              summary: MsgOk,
              detail: 'Configuración Guardada',
            });
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
    } else {
      this.alertError(TitleErrorForm, MsgErrorForm);
    }
  }

  setData(): Configuracion[] {
    this.config.forEach((item) => {
      item.valor = this.formulario.get([item.tipo])?.value.toString();
      item.idUsuario = this.idUsuario;
    });
    return this.config;
  }

  setView() {
    let value = this.formulario.get(['view'])?.value ? 0 : 1;

    this.formulario.patchValue({
      view: value,
    });
  }
}
