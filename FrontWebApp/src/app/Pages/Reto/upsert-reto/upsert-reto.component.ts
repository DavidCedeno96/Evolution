import {
  AfterViewInit,
  Component,
  ElementRef,
  OnInit,
  ViewChild,
} from '@angular/core';
import {
  AbstractControl,
  FormBuilder,
  FormGroup,
  ValidationErrors,
  Validators,
} from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import {
  ComportamientoPregunta,
  TipoArchivo,
  TipoEncuesta,
  TipoReto,
  TipoValidador,
} from 'src/app/Models/Adicional';
import { Reto, Usuario_Reto } from 'src/app/Models/Reto';
import { Usuario } from 'src/app/Models/Usuario';
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
  ChangeRoute,
} from 'src/app/Utils/Constants';
import {
  CaracterInvalid,
  MaxCantItems,
  exp_invalidos,
  exp_numeros,
} from 'src/app/Utils/RegularExpressions';
import { AdicionalService } from 'src/app/services/adicional.service';
import { RetoService } from 'src/app/services/reto.service';
import { UsuarioService } from 'src/app/services/usuario.service';

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
  caracterInvalid = CaracterInvalid();
  maxCantItems = MaxCantItems(5);
  changeRoute = ChangeRoute();
  sugerenciaImagen = SugerenciaImagen;

  @ViewChild('closeModalAsignar') closeModalAsignar!: ElementRef;
  @ViewChild('openModalAsignar') openModalAsignar!: ElementRef;

  sectionIndex: number = 0;

  type: string = '';
  titulo: string = '';

  usuarioReto: Usuario_Reto[] = [];
  usuarios: Usuario[] = [];
  correosValidadores: string[] = [];
  permitirVerificadores: boolean = false;

  verErrorsInputs: boolean = false;

  ttTipoReto: string = '';
  inst: string = '';

  selectedImage!: File;
  previewImage: string = '';
  errorArchivo: boolean = false;
  id: string = '';
  campo: string = '';
  error: number = 0;
  info: string = '';

  formulario!: FormGroup;
  frmUsuario!: FormGroup;

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
    idTipoEncuesta: '',
    tipoEncuesta: '',
    idComportamiento: '',
    comportamientoPregunta: '',
    idTipoArchivo: '',
    tipoArchivo: '',
    idTipoValidador: '',
    tipoValidador: '',
    totalPreguntas: 0,
    usuariosAsignados: 0,
    equiposAsignados: 0,
    validadores: 0,
    puedeValidar: 0,
    enEquipo: -1,
    opsRequeridas: 1,
    items: 0,
    estado: 0,
  };

  tipoReto: TipoReto[] = [];
  tipoEncuesta: TipoEncuesta[] = [];
  tipoValidador: TipoValidador[] = [];
  tipoArchivo: TipoArchivo[] = [];
  comportPreg: ComportamientoPregunta[] = [];

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private retoServicio: RetoService,
    private adicionalServicio: AdicionalService,
    private usuarioServicio: UsuarioService,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      idReto: [this.reto.idReto],
      nombre: [
        this.reto.nombre,
        [
          Validators.required,
          Validators.maxLength(40),
          Validators.pattern(exp_invalidos),
        ],
      ],
      idTipoReto: [this.reto.idTipoReto, [Validators.required]],
      idTipoEncuesta: [this.reto.idTipoEncuesta, [Validators.required]],
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

      idTipoValidador: [this.reto.idTipoValidador, [Validators.required]],

      idTipoArchivo: [this.reto.idTipoArchivo, [Validators.required]],

      opsRequeridas: [this.reto.opsRequeridas],

      items: [
        this.reto.items,
        [
          Validators.required,
          Validators.min(1),
          Validators.max(1000),
          Validators.pattern(exp_numeros),
        ],
      ],

      correosValid: [
        '',
        [
          Validators.required,
          Validators.minLength(7),
          Validators.maxLength(400),
          this.caracterInvalid,
          this.maxCantItems,
        ],
      ],
    });

    this.frmUsuario = this.formBuilder.group({
      buscar: ['', [Validators.required]],
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
          this.changeRoute('/404', {});
          break;
        }
      }
    });
    this.cargarAdicionales();
  }

  cargarData(idReto: string) {
    this.retoServicio.getItem(-1, idReto).subscribe({
      next: (data: any) => {
        let { error, reto, userValidadorLista } = data.response;
        if (error === 0 && userValidadorLista.error === 0) {
          reto.fechaApertura = this.dateFormatInput(reto.fechaApertura);
          reto.fechaCierre = this.dateFormatInput(reto.fechaCierre);

          this.usuarioReto = userValidadorLista.lista;
          this.reto = reto;
          this.formulario.patchValue(reto);
          this.formulario.patchValue({
            tiempo_h: this.formatTiempo(reto.tiempo_ms),
          });

          //Aqui poner los usuarios Validadores
          if (this.usuarioReto.length) {
            this.permitirVerificadores = true;
            let correosValidadores: string[] = [];
            this.usuarioReto.forEach((ur) => {
              correosValidadores.push(ur.usuario.correo.trim());
            });

            this.formulario.patchValue({
              correosValid: correosValidadores.join('\n'),
            });
          } else {
            this.permitirVerificadores = false;
            this.formulario.patchValue({
              correosValid: 'usuario@default.com',
            });
          }

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
          this.changeRoute('/404', {});
        }
      },
    });
  }

  cargarAdicionales() {
    this.adicionalServicio.getListReto(1).subscribe({
      next: (data: any) => {
        let {
          tipoRetoList,
          tipoEncuestaList,
          tipoValidadorList,
          tipoArchivoList,
          comportPreguntaList,
        } = data.response;

        this.tipoReto = tipoRetoList.lista;
        this.tipoEncuesta = tipoEncuestaList.lista;
        this.tipoValidador = tipoValidadorList.lista;
        this.tipoArchivo = tipoArchivoList.lista;
        this.comportPreg = comportPreguntaList.lista;
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

  getUserBuscado(texto: string) {
    this.usuarioServicio.getBuscarList(texto, 1).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        this.info = info;
        this.error = error;
        this.correosValidadores = [];
        if (error === 0) {
          this.usuarios = lista;
        } else {
          this.usuarios = [];
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
          this.changeRoute('/404', {});
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
          this.changeRoute('/404', {});
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
          this.changeRoute('/404', {});
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
    formData.append('idTipoEncuesta', this.reto.idTipoEncuesta.trim());
    formData.append('idComportamiento', this.reto.idComportamiento.trim());
    formData.append('idTipoValidador', this.reto.idTipoValidador.trim());
    formData.append('idTipoArchivo', this.reto.idTipoArchivo.trim());
    formData.append('items', this.reto.items.toString());
    formData.append('opsRequeridas', this.reto.opsRequeridas.toString().trim());

    if (this.selectedImage) {
      formData.append('archivo', this.selectedImage);
    }

    let correos = this.formulario.get(['correosValid'])?.value;

    let listCorreos = correos
      .split('\n')
      .map((correosIds: string) => correosIds.trim());

    listCorreos = listCorreos.filter(
      (correo: string, index: number, self: string[]) =>
        correo !== '' && index === self.indexOf(correo)
    );

    formData.append('jsonList', JSON.stringify(listCorreos));

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
    switch (tipoReto) {
      case 'Trivia': {
        if (this.type === 'crear') {
          this.formulario.patchValue({
            tiempo_ms: 0,
            criterioMinimo: 0,
            idTipoEncuesta: '7c8c2672-2233-486a-a184-f0b51eb4a331',
            idComportamiento: '',
            idTipoArchivo: '7c8c2672-2233-486a-a184-f0b51eb4a331',
          });
        }

        this.formulario.patchValue({
          items: 1,
          idTipoValidador: '7c8c2672-2233-486a-a184-f0b51eb4a331',
          correosValid: 'usuario@default.com',
        });

        this.ttTipoReto =
          'El reto Trivia tiene preguntas de opción múltiple con tiempo y vidas';
        this.inst = this.InstTrivia();
        break;
      }
      case 'Encuesta': {
        if (this.type === 'crear') {
          this.formulario.patchValue({
            idTipoEncuesta: '',
            idComportamiento: '7c8c2672-2233-486a-a184-f0b51eb4a331',
            idTipoArchivo: '7c8c2672-2233-486a-a184-f0b51eb4a331',
          });
        }

        this.formulario.patchValue({
          tiempo_ms: 300000,
          criterioMinimo: 1,

          items: 1,
          idTipoValidador: '7c8c2672-2233-486a-a184-f0b51eb4a331',
          correosValid: 'usuario@default.com',
        });

        this.ttTipoReto =
          'El reto Encuesta recopila información para conocer opiniones u otras cuestiones que les afectan';
        this.inst = this.InstEncuesta_seguimiento();
        break;
      }
      case 'Seguimiento o Evaluación': {
        if (this.type === 'crear') {
          this.formulario.patchValue({
            idTipoEncuesta: '7c8c2672-2233-486a-a184-f0b51eb4a331',
            idComportamiento: '7c8c2672-2233-486a-a184-f0b51eb4a331',
            idTipoArchivo: '7c8c2672-2233-486a-a184-f0b51eb4a331',
          });
        }

        this.formulario.patchValue({
          tiempo_ms: 300000,
          criterioMinimo: 1,

          items: 1,
          idTipoValidador: '7c8c2672-2233-486a-a184-f0b51eb4a331',
          correosValid: 'usuario@default.com',
        });

        this.ttTipoReto =
          'El reto Seguimiento o Evaluación tiene preguntas en las que el usuario puede escribir una respuesta de tipo fecha, hora o texto';
        this.inst = this.InstEncuesta_seguimiento();
        break;
      }
      case 'Recolección': {
        if (this.type === 'crear') {
          this.formulario.patchValue({
            items: 0,
            idTipoValidador: '',
            correosValid: '',
            idTipoArchivo: '',
          });
        }

        this.formulario.patchValue({
          idTipoEncuesta: '7c8c2672-2233-486a-a184-f0b51eb4a331',
          idComportamiento: '7c8c2672-2233-486a-a184-f0b51eb4a331',
          tiempo_ms: 300000,
          criterioMinimo: 1,
        });

        this.ttTipoReto =
          'El reto Recolección premite guardar archivos de acuerto al tipo de archivo seleccionado';
        this.inst = this.InstRecoleccion();
        break;
      }
      case 'Comportamiento': {
        if (this.type === 'crear') {
          this.formulario.patchValue({
            idTipoValidador: '',
            correosValid: '',
            idTipoArchivo: '7c8c2672-2233-486a-a184-f0b51eb4a331',
          });
        }

        this.formulario.patchValue({
          items: 1,

          idTipoEncuesta: '7c8c2672-2233-486a-a184-f0b51eb4a331',
          idComportamiento: '7c8c2672-2233-486a-a184-f0b51eb4a331',
          tiempo_ms: 300000,
          criterioMinimo: 1,
        });

        this.ttTipoReto =
          'El reto Comportamiento premite calificar la conducta de los usuarios asignados al reto';

        this.inst = '';
        break;
      }
    }
  }

  setSection(index: number, tipo: string) {
    /* console.log(this.formulario.valid);
    console.log(this.formulario.value); */
    let error: boolean = this.getValidSection(this.sectionIndex);

    switch (tipo) {
      case 'siguiente': {
        error
          ? this.alertError(TitleErrorForm, MsgErrorForm)
          : (this.sectionIndex = index);

        break;
      }
      case 'anterior': {
        this.sectionIndex = index;
        break;
      }
      case 'nav': {
        error
          ? this.alertError(TitleErrorForm, MsgErrorForm)
          : (this.sectionIndex = index);
        break;
      }
    }
  }

  getValidSection(section: number): boolean {
    let valid: boolean = true;
    switch (section) {
      case 0: {
        this.formulario.get('nombre')?.errors ||
        this.formulario.get('idTipoReto')?.errors ||
        this.formulario.get('enEquipo')?.errors ||
        this.errorArchivo
          ? (valid = true)
          : (valid = false);
        break;
      }
      case 1: {
        this.formulario.get('idComportamiento')?.errors ||
        this.formulario.get('idTipoEncuesta')?.errors ||
        this.formulario.get('criterioMinimo')?.errors ||
        this.formulario.get('tiempo_ms')?.errors ||
        this.formulario.get('items')?.errors ||
        this.formulario.get('idTipoValidador')?.errors ||
        this.formulario.get('idTipoArchivo')?.errors ||
        this.formulario.get('correosValid')?.errors
          ? (valid = true)
          : (valid = false);
        break;
      }
      case 2: {
        this.formulario.get('puntosRecompensa')?.errors ||
        this.formulario.get('creditosObtenidos')?.errors ||
        this.formulario.get('vidas')?.errors
          ? (valid = true)
          : (valid = false);
        break;
      }
      default: {
        this.formulario.get('nombre')?.errors ||
        this.formulario.get('idTipoReto')?.errors ||
        this.formulario.get('enEquipo')?.errors ||
        this.errorArchivo ||
        this.formulario.get('idComportamiento')?.errors ||
        this.formulario.get('idTipoEncuesta')?.errors ||
        this.formulario.get('criterioMinimo')?.errors ||
        this.formulario.get('tiempo_ms')?.errors ||
        this.formulario.get('items')?.errors ||
        this.formulario.get('idTipoValidador')?.errors ||
        this.formulario.get('idTipoArchivo')?.errors ||
        this.formulario.get('correosValid')?.errors ||
        this.formulario.get('puntosRecompensa')?.errors ||
        this.formulario.get('creditosObtenidos')?.errors ||
        this.formulario.get('vidas')?.errors
          ? (valid = true)
          : (valid = false);
      }
    }
    this.verErrorsInputs = valid;

    return valid;
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
  }

  setOpsRequeridas(event: Event) {
    let checked = (event.target as HTMLInputElement).checked;

    checked
      ? this.formulario.patchValue({
          opsRequeridas: 1,
        })
      : this.formulario.patchValue({
          opsRequeridas: 0,
        });
  }

  selectTipoValidador(event: Event) {
    let selectedItem = event.target as HTMLSelectElement;
    let tipoValidador = selectedItem.options[selectedItem.selectedIndex].text;

    if (tipoValidador === 'Usuario') {
      this.permitirVerificadores = true;
      this.formulario.patchValue({
        correosValid: '',
      });
    } else {
      this.permitirVerificadores = false;
      this.formulario.patchValue({
        correosValid: 'usuario@default.com',
      });
    }
  }

  selectUsuario(correo: string, event: Event) {
    let checked = (event.target as HTMLInputElement).checked;

    if (checked) {
      if (!this.correosValidadores.includes(correo)) {
        this.correosValidadores.push(correo);
      }
    } else {
      if (this.correosValidadores.includes(correo)) {
        let i = this.correosValidadores.indexOf(correo);
        this.correosValidadores.splice(i, 1);
      }
    }
  }

  submitFormBuscar(event: any) {
    const botonClickeado = event.submitter.value;
    switch (botonClickeado) {
      case 'buscar': {
        this.setBuscar();
        break;
      }
      case 'agregar': {
        if (this.usuarios.length) {
          this.agregarUsuario();
        }
        break;
      }
      default: {
        this.changeRoute('/404', {});
        break;
      }
    }
  }

  setBuscar() {
    let buscar = this.frmUsuario.get(['buscar'])?.value;
    if (buscar.trim() !== '') {
      this.loading(true, false);
      this.getUserBuscado(buscar);
    } else {
      this.usuarios = [];
    }
  }

  defaultList(event: Event) {
    let text = (event.target as HTMLInputElement).value;
    if (!text.trim()) {
      this.usuarios = [];
      this.error = 0;
      this.frmUsuario.patchValue({ buscar: '' });
    }
  }

  agregarUsuario() {
    let correos: string = this.formulario.get(['correosValid'])?.value;
    this.correosValidadores.forEach((correo) => {
      // Si no contiene entonces va a agregar:
      if (!correos.includes(correo)) {
        correos = `${correos}\n${correo}`;

        this.formulario.patchValue({ correosValid: correos.trim() });
      }
    });

    this.limpiarCampos(false);
  }

  quitarUsuario(correo: string) {
    let correos: string = this.formulario.get(['correosValid'])?.value;

    if (correos.includes(correo)) {
      let auxCorreos: string[] = correos
        .split(/\r\n|\r|\n/, -1)
        .filter(function (item) {
          return item.trim() !== '';
        });

      let indiceAEliminar = auxCorreos.indexOf(correo);

      auxCorreos.splice(indiceAEliminar, 1);

      this.formulario.patchValue({ correosValid: auxCorreos.join('\n') });
    }
  }

  getCorreosValid(): string[] {
    let correos: string = this.formulario.get(['correosValid'])?.value;

    let auxCorreos: string[] = correos
      .split(/\r\n|\r|\n/, -1)
      .filter(function (item) {
        return item.trim() !== '';
      });

    return auxCorreos;
  }

  openModal() {
    this.openModalAsignar.nativeElement.click();
  }

  limpiarCampos(btnCloseClickeado: boolean) {
    if (!btnCloseClickeado) {
      this.closeModalAsignar.nativeElement.click();
    }
    this.frmUsuario.patchValue({ buscar: '' });
    this.correosValidadores = [];
    this.usuarios = [];
    this.verErrorsInputs = false;
  }

  InstTrivia(): string {
    return 'Contesta correctamente las preguntas para ganar puntos y avanza rápido para estar primero en el ranking.';
  }

  InstEncuesta_seguimiento(): string {
    return 'Lee bien las preguntas y contesta todas de acuerdo a tu criterio ¡Diviértete!';
  }

  InstRecoleccion(): string {
    return 'Recoge todos los items para competar el reto, recuerda que debes subir archivos de acuerdo al tipo de archivo seleccionado ¡Diviértete!';
  }
}
