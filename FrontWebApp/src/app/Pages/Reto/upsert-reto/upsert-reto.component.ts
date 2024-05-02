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
  DateCompare,
  DateFormatInput,
  FormatTiempo,
  GetImage,
  ImgSizeMax,
  Loading,
  MsgError,
  MsgErrorForm,
  TitleError,
  TitleErrorForm,
  SugerenciaImagen,
  ImgWidthMax,
  ImgHeightMax,
  SetUpsert,
  HtmlLicencias,
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
  setUpsert = SetUpsert();
  formatTiempo = FormatTiempo();
  dateFormatInput = DateFormatInput();
  dateCompare = DateCompare();
  //objectInvalid = ObjectInvalid();
  caracterInvalid = CaracterInvalid();
  sugerenciaImagen = SugerenciaImagen;

  sectionIndex: number = 0;

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
    criterioMinimo: 0,
    imagen: '',
    idTipoReto: '',
    tipoReto: '',
    idComportamiento: '',
    comportamientoPregunta: '',
    totalPreguntas: 0,
    usuariosAsignados: 0,
    equiposAsignados: 0,
    enEquipo: -1,
    estado: 0,
  };

  tipoReto: TipoReto[] = [];
  comportPreg: ComportamientoPregunta[] = [];

  sectionsByTipoReto: number[] = [1, 1, 1];

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
      idTipoReto: [this.reto.idTipoReto, [Validators.required]],
      enEquipo: [
        this.reto.enEquipo,
        [
          Validators.required,
          Validators.min(0),
          Validators.max(1),
          Validators.pattern(exp_numeros),
        ],
      ],
      fechaApertura: [this.reto.fechaApertura],
      fechaCierre: [this.reto.fechaCierre],
      vidas: [
        this.reto.vidas,
        [
          Validators.required,
          Validators.min(0),
          Validators.max(10),
          Validators.pattern(exp_numeros),
        ],
      ],
      tiempo_h: [''],
      tiempo_ms: [
        this.reto.tiempo_ms,
        [
          Validators.required,
          Validators.min(300000), // 5 minutos
          Validators.max(7200000), // 2 horas
          Validators.pattern(exp_numeros),
        ],
      ],
      puntosRecompensa: [
        this.reto.puntosRecompensa,
        [
          Validators.required,
          Validators.min(1),
          Validators.max(1000),
          Validators.pattern(exp_numeros),
        ],
      ],
      creditosObtenidos: [
        this.reto.creditosObtenidos,
        [
          Validators.required,
          Validators.min(0),
          Validators.max(1000),
          Validators.pattern(exp_numeros),
        ],
      ],
      criterioMinimo: [
        this.reto.criterioMinimo,
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
      if ((idReto === '' && this.type === 'editar') || !params['type']) {
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
          this.formulario.patchValue({
            tiempo_h: this.formatTiempo(reto.tiempo_ms),
          });

          this.setSectionsByTipoReto(this.reto.tipoReto);
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
          this.setUpsert(true, 'Registro Creado');
          this.router.navigate(['/view-reto']);
        } else if (error === 2) {
          this.alertError(TitleErrorForm, info + HtmlLicencias);
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
    this.retoServicio.update(this.getFormData()).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.setUpsert(true, 'Registro Actualizado');
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

    this.reto.fechaApertura instanceof Date || this.reto.fechaApertura === ''
      ? formData.append('fechaApertura', '1800-01-01')
      : formData.append('fechaApertura', this.reto.fechaApertura);

    this.reto.fechaCierre instanceof Date || this.reto.fechaCierre === ''
      ? formData.append('fechaCierre', '1800-01-01')
      : formData.append('fechaCierre', this.reto.fechaCierre);

    formData.append('enEquipo', this.reto.enEquipo.toString().trim());
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
    formData.append('criterioMinimo', this.reto.criterioMinimo.toString());
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

    if (this.selectedImage) {
      let reader = new FileReader();
      reader.onload = (e: any) => {
        let img = new Image();
        img.src = e.target.result;
        img.onload = () => {
          let w = (img as HTMLImageElement).width;
          let h = (img as HTMLImageElement).height;

          if (
            this.selectedImage.size > ImgSizeMax ||
            w > ImgWidthMax ||
            h > ImgHeightMax
          ) {
            this.errorArchivo = true;
          } else {
            this.errorArchivo = false;
          }
        };

        this.previewImage = img.src;
      };
      reader.readAsDataURL(this.selectedImage);
    } else {
      this.errorArchivo = false;
    }
  }

  selectedTipoRetoName(e: Event) {
    let selectedIndex = (e.target as HTMLSelectElement).selectedIndex;
    let options = (e.target as HTMLSelectElement).options;

    let text = options[selectedIndex].text;

    this.reto.tipoReto = text;

    this.setSectionsByTipoReto(text);
  }

  setSectionsByTipoReto(tipoReto: string) {
    if (tipoReto === 'Trivia') {
      this.sectionsByTipoReto[1] = 1;

      this.formulario.patchValue({
        tiempo_ms: 0,
        criterioMinimo: 0,
        puntosRecompensa: 0,
      });
    } else if (tipoReto === 'Encuesta') {
      this.sectionsByTipoReto[1] = 0;

      this.formulario.patchValue({
        tiempo_ms: 300000,
        criterioMinimo: 1,
        puntosRecompensa: 1,
      });
    }
  }

  setSection(index: number, tipo: string) {
    /* console.log(this.formulario.valid);
    console.log(this.formulario.value); */
    let error: boolean = false;

    if (tipo === 'siguiente') {
      for (let i = 0; i < this.sectionsByTipoReto.length; i++) {
        if (this.sectionsByTipoReto[i] === 0) {
          index += 1;
        }
      }

      switch (index) {
        case 1: {
          this.formulario.get('nombre')?.errors ||
          this.formulario.get('idTipoReto')?.errors
            ? (error = true)
            : (error = false);
          break;
        }
        case 2: {
          this.formulario.get('vidas')?.errors ||
          this.formulario.get('puntosRecompensa')?.errors ||
          this.formulario.get('creditosObtenidos')?.errors ||
          this.formulario.get('tiempo_ms')?.errors ||
          this.formulario.get('criterioMinimo')?.errors
            ? (error = true)
            : (error = false);
          break;
        }
      }

      if (error) {
        this.verErrorsInputs = true;
        this.alertError(TitleErrorForm, MsgErrorForm);
      } else {
        this.verErrorsInputs = false;
        this.sectionIndex = index;
      }
    } else if (tipo === 'anterior') {
      for (let i = this.sectionsByTipoReto.length - 1; i >= 0; i--) {
        if (this.sectionsByTipoReto[i] === 0) {
          index -= 1;
        }
      }

      this.sectionIndex = index;
    } else if ('nav') {
      this.formulario.get('nombre')?.errors ||
      this.formulario.get('idTipoReto')?.errors ||
      this.formulario.get('vidas')?.errors ||
      this.formulario.get('puntosRecompensa')?.errors ||
      this.formulario.get('creditosObtenidos')?.errors ||
      this.formulario.get('tiempo_ms')?.errors ||
      this.formulario.get('criterioMinimo')?.errors
        ? (error = true)
        : (error = false);

      if (error) {
        this.verErrorsInputs = true;
        this.alertError(TitleErrorForm, MsgErrorForm);
      } else {
        this.verErrorsInputs = false;
        this.sectionIndex = index;
      }
    }
  }

  setTiempo() {
    let hora = this.formulario.get(['tiempo_h'])?.value;
    const partesHora = hora.split(':');

    const horas = parseInt(partesHora[0], 10) * 3600 * 1000; // Convertir horas a milisegundos
    const minutos = parseInt(partesHora[1], 10) * 60 * 1000; // Convertir minutos a milisegundos
    const segundos = parseInt(partesHora[2], 10) * 1000; // Convertir segundos a milisegundos

    const totalMilisegundos = horas + minutos + segundos;

    this.formulario.patchValue({
      tiempo_ms: totalMilisegundos,
    });

    /* console.log(
      typeof this.formulario.get(['tiempo_h'])?.value,
      this.formulario.get(['tiempo_h'])?.value,
      totalMilisegundos
    ); */
  }
}
