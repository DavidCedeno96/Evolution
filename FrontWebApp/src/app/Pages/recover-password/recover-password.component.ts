import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Loading } from 'src/app/Utils/Constants';

@Component({
  selector: 'app-recover-password',
  templateUrl: './recover-password.component.html',
  styleUrls: ['./recover-password.component.css'],
})
export class RecoverPasswordComponent {
  loading = Loading();

  verErrorsInputs: boolean = false;
  formulario!: FormGroup;

  correoEnviado: boolean = false;

  constructor(private formBuilder: FormBuilder) {
    this.formulario = this.formBuilder.group({
      correo: [
        '',
        [Validators.required, Validators.maxLength(60), Validators.email],
      ],
    });
  }

  submit() {
    if (this.formulario.valid) {
      this.verErrorsInputs = false;
      //this.usuario = this.formulario.value;
      this.loading(true, false);
      this.enviarCorreo();
    } else {
      this.verErrorsInputs = true;
    }
  }

  enviarCorreo() {
    console.log('Enviando el correo...');
    setTimeout(() => {
      this.correoEnviado = true;
      this.loading(false, false);
    }, 2000);
  }
}
