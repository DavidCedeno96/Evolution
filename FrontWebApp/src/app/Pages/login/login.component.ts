import { Component, OnInit, Renderer2, ElementRef } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent implements OnInit {
  imgFondo: string = '';
  verPassword: boolean = false;
  verErrorsInputs: boolean = false;
  numClicksLogin: number = 0;

  formulario!: FormGroup;

  constructor(
    private renderer: Renderer2,
    private el: ElementRef,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      correo: [
        '',
        [Validators.required, Validators.maxLength(60), Validators.email],
      ],
      contrasena: ['', [Validators.required, Validators.maxLength(90)]],
      recuerdame: [''],
    });
  }

  ngOnInit(): void {
    this.config();
  }

  config() {
    this.imgFondo = 'fondo.png';
    const fondo = this.el.nativeElement.querySelector('.fondoImagen');
    if (fondo) {
      this.renderer.setStyle(
        fondo,
        'background-image',
        `url("assets/img/login-register/${this.imgFondo}")`
      );
    }
  }

  iniciarSesion() {
    console.log(this.formulario.valid);
    console.log(this.formulario.value);

    this.numClicksLogin += 1;
    if (this.formulario.valid) {
      this.verErrorsInputs = false;
      console.log('Iniciando Sesion...');
    } else {
      this.verErrorsInputs = true;
    }
  }

  togglePassword() {
    this.verPassword = !this.verPassword;
  }
}
