import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Response } from 'src/app/Models/Response';
import {
  AlertError,
  Loading,
  MsgError,
  MsgErrorForm,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { EquipoService } from 'src/app/services/equipo.service';
import { exp_invalidos } from 'src/app/Utils/RegularExpressions';

@Component({
  selector: 'app-mass-actions-asig-user-equipo',
  templateUrl: './mass-actions-asig-user-equipo.component.html',
  styleUrls: ['./mass-actions-asig-user-equipo.component.css'],
})
export class MassActionsAsigUserEquipoComponent implements OnInit {
  alertError = AlertError();
  loading = Loading();

  verErrorsInputs: boolean = false;

  modal: boolean = false;
  listCorreosIds: string[] = [];
  responseList: Response[] = [];

  idEquipo: string = '';

  formulario!: FormGroup;

  constructor(
    private equipoService: EquipoService,
    private router: Router,
    private route: ActivatedRoute,
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

  ngOnInit(): void {
    this.getRouteParams();
  }

  getRouteParams() {
    this.route.queryParams.subscribe((params) => {
      this.idEquipo = params['equipo'];
      if (this.idEquipo === '' || !params['equipo']) {
        history.back();
      }
    });
  }

  setUserValues() {
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
      this.asignarUsuarios();
    } else {
      this.verErrorsInputs = true;
      this.alertError(TitleErrorForm, MsgErrorForm);
    }
  }

  asignarUsuarios() {
    this.equipoService
      .createUsuario_EquipoByCorreosIds(this.idEquipo, this.getFormData())
      .subscribe({
        next: (data: any) => {
          this.responseList = data.response;
          if (this.responseList.length) {
            this.modal = true;
          } else {
            this.back();
          }
          this.loading(false, false);
        },
        error: (e) => {
          console.error(e);
          if (e.status === 401 || e.status === 403) {
            this.router.navigate(['/']);
          } else {
            this.alertError(TitleError, MsgError);
            this.loading(false, false);
          }
        },
      });
  }

  getFormData(): FormData {
    let formData = new FormData();
    formData.append('jsonList', JSON.stringify(this.listCorreosIds));

    return formData;
  }

  back() {
    history.back();
  }
}
