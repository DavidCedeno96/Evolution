import { AfterViewInit, Component, OnInit } from '@angular/core';
import {
  AbstractControl,
  FormBuilder,
  FormGroup,
  ValidationErrors,
  Validators,
} from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ComportamientoPregunta, TipoReto } from 'src/app/Models/Adicional';
import { Reto } from 'src/app/Models/Reto';
import {
  AlertError,
  DateFormatInput,
  GetImage,
  ImgSizeMax,
  Loading,
  MsgError,
  MsgErrorForm,
  ObjectInvalid,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import {
  CaracterInvalid,
  exp_invalidos,
  exp_numeros,
} from 'src/app/Utils/RegularExpressions';
import { AdicionalService } from 'src/app/services/adicional.service';
import { RetoService } from 'src/app/services/reto.service';

@Component({
  selector: 'app-upsert-reto',
  templateUrl: './upsert-reto.component.html',
  styleUrls: ['./upsert-reto.component.css'],
})
export class UpsertRetoComponent implements OnInit, AfterViewInit {
  getImage = GetImage();
  alertError = AlertError();
  loading = Loading();
  dateFormatInput = DateFormatInput();
  objectInvalid = ObjectInvalid();
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

  reto: Reto = {
    idReto: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: '',
    fechaApertura: new Date(),
    fechaCierre: new Date(),
    vidas: 0,
    tiempo_ms: 0,
    puntosRecompensa: 0,
    creditosObtenidos: 0,
    instrucciones: '',
    imagen: '',
    idTipoReto: '',
    tipoReto: '',
    idComportamiento: '',
    comportamiento: '',
    estado: 0,
  };

  tipoReto: TipoReto[] = [];
  comportPreg: ComportamientoPregunta[] = [];

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private retoServicio: RetoService,
    private adicionalServicio: AdicionalService,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      idReto: [this.reto.idReto],
      nombre: [
        this.reto.nombre,
        [
          Validators.required,
          Validators.maxLength(30),
          Validators.pattern(exp_invalidos),
        ],
      ],
      fechaApertura: [this.reto.fechaApertura, [this.objectInvalid]],
      fechaCierre: [this.reto.fechaCierre, [this.objectInvalid]],
      vidas: [
        this.reto.vidas,
        [
          Validators.required,
          Validators.min(1),
          Validators.max(10),
          Validators.pattern(exp_numeros),
        ],
      ],
      tiempo_ms: [
        this.reto.tiempo_ms,
        [
          Validators.required,
          Validators.min(10000), // 10 segundos
          Validators.max(300000), // 5 minutos
          Validators.pattern(exp_numeros),
        ],
      ],
      puntosRecompensa: [
        this.reto.puntosRecompensa,
        [
          Validators.required,
          Validators.min(1),
          Validators.max(100),
          Validators.pattern(exp_numeros),
        ],
      ],
      creditosObtenidos: [
        this.reto.creditosObtenidos,
        [
          Validators.required,
          Validators.min(1),
          Validators.max(100),
          Validators.pattern(exp_numeros),
        ],
      ],
      instrucciones: [
        this.reto.instrucciones,
        [Validators.maxLength(300), this.caracterInvalid],
      ],
      imagen: [this.reto.imagen],

      idTipoReto: [this.reto.idTipoReto, [Validators.required]],
      idComportamiento: [this.reto.idComportamiento, [Validators.required]],
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
      let idReto = params['reto'];
      if (idReto === '' && this.type === 'editar') {
        history.back();
      }
      switch (this.type) {
        case 'crear': {
          this.titulo = 'nuevo reto';
          break;
        }
        case 'editar': {
          this.id = idReto;
          this.titulo = 'editar reto';
          break;
        }
        default: {
          this.titulo = '';
          history.back();
          break;
        }
      }
    });
    this.cargarAdicionales();
  }

  cargarData(idReto: string) {
    this.retoServicio.getItem(-1, idReto).subscribe({
      next: (data: any) => {
        let { error, reto } = data.response;
        if (error === 0) {
          reto.fechaApertura = this.dateFormatInput(reto.fechaApertura);
          reto.fechaCierre = this.dateFormatInput(reto.fechaCierre);

          this.reto = reto;
          this.formulario.patchValue(reto);
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

  cargarAdicionales() {
    this.adicionalServicio.getListReto(1).subscribe({
      next: (data: any) => {
        let { tipoRetoList, comportPreguntaList } = data.response;
        this.tipoReto = tipoRetoList.lista;
        this.comportPreg = comportPreguntaList.lista;
      },
      error: (e) => {
        console.error(e);
        if (e.status === 401 || e.status === 403) {
          this.router.navigate(['/']);
        } else {
          this.alertError(TitleError, MsgError);
        }
      },
    });
  }

  upsert() {
    //this.numClicksSave += 1;
    if (this.formulario.valid && !this.errorArchivo) {
      this.verErrorsInputs = false;
      this.reto = this.formulario.value;
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
    this.retoServicio.create(this.getFormData()).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;

        if (error === 0) {
          this.router.navigate(['/view-reto']);
        } else if (campo !== '') {
          console.log('Cambpo', campo);
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
    this.retoServicio.update(this.getFormData()).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.router.navigate(['/view-reto']);
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
    formData.append('idReto', this.reto.idReto);
    formData.append('nombre', this.reto.nombre.trim());
    formData.append('fechaApertura', this.reto.fechaApertura.toString());
    formData.append('fechaCierre', this.reto.fechaCierre.toString());
    formData.append('vidas', this.reto.vidas.toString().trim());
    formData.append('tiempo_ms', this.reto.tiempo_ms.toString().trim());
    formData.append(
      'puntosRecompensa',
      this.reto.puntosRecompensa.toString().trim()
    );
    formData.append(
      'creditosObtenidos',
      this.reto.creditosObtenidos.toString().trim()
    );
    formData.append('instrucciones', this.reto.instrucciones.trim());
    formData.append('idTipoReto', this.reto.idTipoReto.trim());
    formData.append('idComportamiento', this.reto.idComportamiento.trim());

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
