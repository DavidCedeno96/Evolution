import { Component, OnInit, Renderer2, ElementRef } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { timeout } from 'rxjs';
import {
  AlertError,
  Loading,
  MsgErrorForm,
  TitleErrorForm,
} from 'src/app/Utils/Constants';

@Component({
  selector: 'app-upsert-user',
  templateUrl: './upsert-user.component.html',
  styleUrls: ['./upsert-user.component.css'],
})
export class UpsertUserComponent implements OnInit {
  alertError = AlertError();
  verPassword: boolean = false;
  verErrorsInputs: boolean = false;
  numClicksSave: number = 0;

  formulario!: FormGroup;
  selectedFoto!: File;
  previewFoto: string = '';
  ErrorArchivo: boolean = false;

  constructor(
    private renderer: Renderer2,
    private el: ElementRef,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      nombre: ['', [Validators.required, Validators.maxLength(23)]],
      apellido: ['', [Validators.required, Validators.maxLength(23)]],
      correo: [
        '',
        [Validators.required, Validators.maxLength(60), Validators.email],
      ],
      contrasena: ['', [Validators.required, Validators.maxLength(60)]],
      celular: ['', [Validators.maxLength(15), Validators.minLength(10)]],
      idArea: [''],
      idCiudad: [''],
      recuerdame: [''],
    });
  }

  ngOnInit(): void {}

  save() {
    console.log(this.formulario.valid);
    console.log(this.formulario.value);

    this.numClicksSave += 1;
    if (this.formulario.valid) {
      this.verErrorsInputs = false;
      console.log('Creando Usuario...');
    } else {
      this.verErrorsInputs = true;

      this.alertError(TitleErrorForm, MsgErrorForm);
    }
  }

  onFileSelected(event: Event) {
    this.selectedFoto = (event.target as HTMLInputElement).files![0];
    this.ErrorArchivo = false;
    if (this.selectedFoto.size > 0) {
      let reader = new FileReader();
      reader.onload = (e: any) => {
        this.previewFoto = e.target.result;
      };
      reader.readAsDataURL(this.selectedFoto);
    }
    console.log(this.selectedFoto.name, this.previewFoto);
  }

  togglePassword() {
    this.verPassword = !this.verPassword;
  }
}
