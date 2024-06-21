import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
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
import { RetoService } from 'src/app/services/reto.service';

@Component({
  selector: 'app-mass-actions-asig-user-reto',
  templateUrl: './mass-actions-asig-user-reto.component.html',
  styleUrls: ['./mass-actions-asig-user-reto.component.css'],
})
export class MassActionsAsigUserRetoComponent implements OnInit {
  alertError = AlertError();
  loading = Loading();
  changeRoute = ChangeRoute();

  verErrorsInputs: boolean = false;

  modal: boolean = false;
  listCorreosIds: string[] = [];
  responseList: Response[] = [];

  idReto: string = '';

  formulario!: FormGroup;

  constructor(
    private retosService: RetoService,
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
      this.idReto = params['reto'];
      if (this.idReto === '' || !params['reto']) {
        this.changeRoute('/404', {});
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
    this.retosService
      .createUsuario_RetoByCorreosIds(this.idReto, this.getFormData())
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
            this.changeRoute('/404', {});
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
