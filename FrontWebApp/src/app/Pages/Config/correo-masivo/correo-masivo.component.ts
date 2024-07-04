import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { CorreoEnvio } from 'src/app/Models/CorreoEnvio';
import {
  AlertError,
  ChangeRoute,
  Loading,
  MsgEditado,
  MsgErrorForm,
  MsgOk,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { exp_invalidos, exp_numeros } from 'src/app/Utils/RegularExpressions';
import { CorreoEnvioService } from 'src/app/services/correo-envio.service';

@Component({
  selector: 'app-correo-masivo',
  templateUrl: './correo-masivo.component.html',
  styleUrls: ['./correo-masivo.component.css'],
  providers: [MessageService],
})
export class CorreoMasivoComponent implements OnInit {
  loading = Loading();
  alertError = AlertError();
  changeRoute = ChangeRoute();

  verPassword: boolean = false;
  verErrorsInputs: boolean = false;
  numClicksSave: number = 0;

  campo: string = '';
  error: number = 0;

  formulario!: FormGroup;
  correoEnvio: CorreoEnvio = {
    idCorreo: '',
    nombre: '',
    correo: '',
    password: '',
    puerto: 587,
    host: '',
  };

  constructor(
    private messageService: MessageService,
    private router: Router,
    private correoEnvioService: CorreoEnvioService,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      idCorreo: [this.correoEnvio.idCorreo],
      correo: [
        this.correoEnvio.correo,
        [Validators.required, Validators.maxLength(60)], //, Validators.email
      ],
      nombre: [
        this.correoEnvio.nombre,
        [Validators.maxLength(60), Validators.pattern(exp_invalidos)],
      ],
      password: [
        this.correoEnvio.password,
        [Validators.maxLength(100), Validators.pattern(exp_invalidos)],
      ],
      puerto: [
        this.correoEnvio.puerto,
        [
          Validators.required,
          Validators.maxLength(5),
          Validators.pattern(exp_numeros),
        ],
      ],
      host: [
        this.correoEnvio.host,
        [
          Validators.required,
          Validators.maxLength(60),
          Validators.pattern(exp_invalidos),
        ],
      ],
    });
  }

  ngOnInit(): void {
    this.loading(true, false);
    this.cargarData();
  }

  cargarData() {
    this.correoEnvioService.getItem().subscribe({
      next: (data: any) => {
        let { error, info, correoEnvio } = data.response;
        if (error === 0) {
          this.correoEnvio = correoEnvio;

          this.formulario.patchValue(correoEnvio);
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

  upsert() {
    this.numClicksSave += 1;
    if (this.formulario.valid) {
      this.verErrorsInputs = false;
      this.correoEnvio = this.formulario.value;

      this.loading(true, false);
      this.update();
    } else {
      this.verErrorsInputs = true;

      this.alertError(TitleErrorForm, MsgErrorForm);
    }
  }

  update() {
    this.correoEnvioService.update(this.correoEnvio).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.messageService.add({
            severity: 'success',
            summary: MsgOk,
            detail: MsgEditado,
          });
        } else {
          this.error = error;
          this.campo = campo;
          this.alertError(TitleErrorForm, info); //MsgErrorForm
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

  togglePassword() {
    this.verPassword = !this.verPassword;
  }
}
