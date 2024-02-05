import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Recompensa } from 'src/app/Models/Recompensa';
import {
  AlertError,
  GetImage,
  ImgSizeMax,
  Loading,
  MsgError,
  MsgErrorForm,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import {
  CaracterInvalid,
  exp_invalidos,
  exp_numeros,
} from 'src/app/Utils/RegularExpressions';
import { RecompensaService } from 'src/app/services/recompensa.service';

@Component({
  selector: 'app-upsert-recompensa',
  templateUrl: './upsert-recompensa.component.html',
  styleUrls: ['./upsert-recompensa.component.css'],
})
export class UpsertRecompensaComponent implements OnInit, AfterViewInit {
  getImage = GetImage();
  alertError = AlertError();
  loading = Loading();
  caracterInvalid = CaracterInvalid();

  type: string = '';
  titulo: string = '';

  verErrorsInputs: boolean = false;

  selectedImage!: File;
  previewImage: string = '';
  errorArchivo: boolean = false;
  id: string = '';
  campo: string = '';
  error: number = 0;
  info: string = '';

  formulario!: FormGroup;
  recompensa: Recompensa = {
    idRecompensa: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: '',
    descripcion: '',
    imagen: '',
    cantDisponible: 0,
    cantCanje: 0,
    totalUsuarios: 0,
  };

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private recompensaServicio: RecompensaService,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      idRecompensa: [this.recompensa.idRecompensa],
      nombre: [
        this.recompensa.nombre,
        [
          Validators.required,
          Validators.maxLength(60),
          Validators.pattern(exp_invalidos),
        ],
      ],
      descripcion: [
        this.recompensa.descripcion,
        [Validators.maxLength(250), this.caracterInvalid],
      ],
      cantDisponible: [
        this.recompensa.cantDisponible,
        [
          Validators.required,
          Validators.min(1),
          Validators.max(99999),
          Validators.pattern(exp_numeros),
        ],
      ],
      cantCanje: [
        this.recompensa.cantCanje,
        [
          Validators.required,
          Validators.min(1),
          Validators.max(9999),
          Validators.pattern(exp_numeros),
        ],
      ],

      imagen: [this.recompensa.imagen],
    });
  }

  ngOnInit(): void {
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    if (this.type === 'editar') {
      this.loading(true, false);
      this.cargarData(this.id);
    }
  }

  getRouteParams() {
    this.route.queryParams.subscribe((params) => {
      this.type = params['type'];
      let idRecompensa = params['recompensa'];
      if (idRecompensa === '' && this.type === 'editar') {
        history.back();
      }
      switch (this.type) {
        case 'crear': {
          this.titulo = 'nueva recompensa';
          break;
        }
        case 'editar': {
          this.id = idRecompensa;
          this.titulo = 'editar recompensa';
          break;
        }
        default: {
          this.titulo = '';
          history.back();
          break;
        }
      }
    });
  }

  cargarData(idRecompensa: string) {
    this.recompensaServicio.getItem(-1, idRecompensa).subscribe({
      next: (data: any) => {
        let { error, recompensa } = data.response;
        if (error === 0) {
          this.recompensa = recompensa;
          this.formulario.patchValue(recompensa);
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
          history.back();
        }
      },
    });
  }

  upsert() {
    if (this.formulario.valid && !this.errorArchivo) {
      this.verErrorsInputs = false;
      this.recompensa = this.formulario.value;
      //console.log('GUARDANDO ......');

      this.loading(true, false);
      switch (this.type) {
        case 'crear': {
          this.create();
          break;
        }
        case 'editar': {
          this.update();
          break;
        }
        default: {
          this.loading(false, false);
          history.back();
          break;
        }
      }
    } else {
      this.verErrorsInputs = true;

      this.alertError(TitleErrorForm, MsgErrorForm);
    }
  }

  create() {
    this.recompensaServicio.create(this.getFormData()).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.router.navigate(['/view-recompensa']);
        } else if (campo !== '') {
          this.error = error;
          this.campo = campo;
          this.info = info;
          this.alertError(TitleErrorForm, info); //MsgErrorForm
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

  update() {
    this.recompensaServicio.update(this.getFormData()).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.router.navigate(['/view-recompensa']);
        } else if (campo !== '') {
          this.error = error;
          this.campo = campo;
          this.info = info;
          this.alertError(TitleErrorForm, info); //MsgErrorForm
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
    formData.append('idRecompensa', this.recompensa.idRecompensa);
    formData.append('nombre', this.recompensa.nombre.trim());
    formData.append('descripcion', this.recompensa.descripcion.trim());
    formData.append(
      'cantDisponible',
      this.recompensa.cantDisponible.toString()
    );
    formData.append('cantCanje', this.recompensa.cantCanje.toString());

    if (this.selectedImage) {
      formData.append('archivo', this.selectedImage);
    }

    return formData;
  }

  onFileSelected(event: Event) {
    this.selectedImage = (event.target as HTMLInputElement).files![0];

    if (this.selectedImage.size > ImgSizeMax) {
      this.errorArchivo = true;
    } else {
      this.errorArchivo = false;
    }

    if (this.selectedImage.size > 0) {
      let reader = new FileReader();
      reader.onload = (e: any) => {
        this.previewImage = e.target.result;
      };
      reader.readAsDataURL(this.selectedImage);
    }
    console.log(this.selectedImage.name, this.previewImage);
  }
}
