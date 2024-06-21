import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Response } from 'src/app/Models/Response';
import {
  AlertError,
  ChangeRoute,
  Loading,
  MsgError,
  MsgErrorForm,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { exp_invalidos } from 'src/app/Utils/RegularExpressions';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-mass-actions-user',
  templateUrl: './mass-actions-user.component.html',
  styleUrls: ['./mass-actions-user.component.css'],
})
export class MassActionsUserComponent implements OnInit {
  alertError = AlertError();
  loading = Loading();
  changeRoute = ChangeRoute();

  listCorreosIds: string[] = [];
  responseList: Response[] = [];
  currentEstado: number = 0;

  modal: boolean = false;
  verErrorsInputs: boolean = false;
  formulario!: FormGroup;

  constructor(
    private usuarioService: UsuarioService,
    private router: Router,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      correosIds: [
        '',
        [
          Validators.required,
          Validators.minLength(5),
          Validators.pattern(exp_invalidos),
        ],
      ],
    });
  }

  ngOnInit(): void {}

  setUserValues(event: any) {
    const botonClickeado = event.submitter.value;

    if (this.formulario.valid) {
      this.verErrorsInputs = false;
      let correosIds = this.formulario.get(['correosIds'])?.value;

      this.listCorreosIds = correosIds
        .split('\n')
        .map((correosIds: string) => correosIds.trim());

      this.listCorreosIds = this.listCorreosIds.filter(
        (correoId, index, self) =>
          correoId !== '' && index === self.indexOf(correoId)
      );

      this.loading(true, false);
      switch (botonClickeado) {
        case 'desactivar': {
          this.cambioEstado(0);
          break;
        }
        case 'activar': {
          this.cambioEstado(1);
          break;
        }
        default: {
          this.loading(false, false);
          console.error('Error de accion masiva');
          break;
        }
      }
    } else {
      this.verErrorsInputs = true;
      this.alertError(TitleErrorForm, MsgErrorForm);
    }
  }

  cambioEstado(estado: number) {
    this.usuarioService
      .updateEstadoByCorreosIds(this.getFormData(estado))
      .subscribe({
        next: (data: any) => {
          this.responseList = data.response;
          if (this.responseList.length) {
            this.modal = true;
            this.currentEstado = estado;
          } else {
            this.router.navigate(['/view-user']);
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

  getFormData(estado: number): FormData {
    let formData = new FormData();
    formData.append('estado', estado.toString());
    formData.append('jsonList', JSON.stringify(this.listCorreosIds));

    return formData;
  }
}
