import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Notificacion } from 'src/app/Models/Notificacion';
import {
  AlertError,
  ChangeRoute,
  Loading,
  MsgError,
  MsgErrorForm,
  SetUpsert,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { CaracterInvalid, exp_numeros } from 'src/app/Utils/RegularExpressions';
import { NotificacionService } from 'src/app/services/notificacion.service';

@Component({
  selector: 'app-upsert-notificacion',
  templateUrl: './upsert-notificacion.component.html',
  styleUrls: ['./upsert-notificacion.component.css'],
})
export class UpsertNotificacionComponent implements OnInit, AfterViewInit {
  alertError = AlertError();
  loading = Loading();
  caracterInvalid = CaracterInvalid();
  setUpsert = SetUpsert();
  changeRoute = ChangeRoute();

  id: string = '';
  titulo: string = 'Editar Notificación';

  minNumDesc: number = 0;

  formulario!: FormGroup;
  verErrorsInputs: boolean = false;

  notificacion: Notificacion = {
    idNotificacion: '4',
    nombre: 'Notificar a los usuarios cuando el reto esta por cerrarse',
    estado: 0,
    msgPersonalizado: 'este es otro el mensaje personalizado',
    descripcion: 'Días restantes',
    numDesc: 10,
    enviarCorreo: 0,
  };

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private formBuilder: FormBuilder,
    private notificacionServicio: NotificacionService
  ) {
    this.formulario = this.formBuilder.group({
      idNotificacion: [this.notificacion.idNotificacion],
      estado: [
        this.notificacion.estado,
        [
          /* Validators.required,
          Validators.min(0),
          Validators.max(1),
          Validators.pattern(exp_numeros), */
        ],
      ],
      msgPersonalizado: [
        this.notificacion.msgPersonalizado,
        [Validators.maxLength(350), this.caracterInvalid],
      ],
      numDesc: [
        this.notificacion.numDesc,
        [
          Validators.required,
          Validators.min(this.minNumDesc),
          Validators.max(300),
          Validators.pattern(exp_numeros),
        ],
      ],
    });
  }

  ngOnInit(): void {
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    this.loading(true, false);
    this.cargarData(this.id);
  }

  getRouteParams() {
    this.route.queryParams.subscribe((params) => {
      let idNotificacion = params['notificacion'];
      if (!params['notificacion']) {
        this.changeRoute('/404', {});
      } else {
        this.id = idNotificacion;
      }
    });
  }

  cargarData(idNotificacion: string) {
    this.notificacionServicio.getItem(idNotificacion).subscribe({
      next: (data: any) => {
        let { error, notificacion } = data.response;
        if (error === 0) {
          this.notificacion = notificacion;
          this.formulario.patchValue(notificacion);
          if (notificacion.descripcion) {
            this.minNumDesc = 1;
            this.formulario.get('numDesc')?.setValidators([Validators.min(1)]);
            this.formulario.get('numDesc')?.updateValueAndValidity();
          }
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

  upsert() {
    if (this.formulario.valid) {
      this.verErrorsInputs = false;
      this.setData();

      this.loading(true, false);
      this.update();
    } else {
      this.verErrorsInputs = true;

      this.alertError(TitleErrorForm, MsgErrorForm);
    }
  }

  update() {
    this.notificacionServicio.update(this.notificacion).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.setUpsert(true, 'Registro Actualizado');
          this.router.navigate(['/config/notification']);
        } else if (campo !== '') {
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

  setData() {
    let estado = this.formulario.get(['estado'])?.value;

    this.notificacion.idNotificacion = this.id;
    this.notificacion.estado = estado ? 1 : 0;
    this.notificacion.msgPersonalizado = this.formulario
      .get(['msgPersonalizado'])
      ?.value.trim();

    this.notificacion.numDesc = this.formulario.get(['numDesc'])?.value;
  }
}
