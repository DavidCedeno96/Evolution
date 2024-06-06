import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Reto } from 'src/app/Models/Reto';
import {
  AlertError,
  ChangeRoute,
  DateCompare,
  FileSizeMax,
  ImgHeightMax,
  ImgSizeMax,
  ImgWidthMax,
  Loading,
  MsgError,
  ReproducirSonido,
  SoundQuizVictory,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { RetoService } from 'src/app/services/reto.service';
import { Response } from 'src/app/Models/Response';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { exp_invalidos } from 'src/app/Utils/RegularExpressions';

@Component({
  selector: 'app-recoleccion',
  templateUrl: './recoleccion.component.html',
  styleUrls: ['./recoleccion.component.css'],
})
export class RecoleccionComponent implements OnInit, AfterViewInit {
  load = Loading();
  dateCompare = DateCompare();
  alertError = AlertError();
  reproducirSonido = ReproducirSonido();
  changeRoute = ChangeRoute();

  @ViewChild('fileInput') fileInput: any;

  headerDialog: string = 'Archivos';
  sugerenciaArchivo: string = '';
  defaultImg: string = '';

  tipoArchivo: string = '';

  idReto: string = '';

  previewFiles: string[] = [];
  files: File[] = [];
  urlsVideos: string[] = [];
  responseFiles: Response[] = [];
  modal: boolean = false;

  verErrorsInputs: boolean = false;

  formulario!: FormGroup;

  reto: Reto = {
    idReto: '',
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
    enEquipo: 0,
    estado: 0,
    opsRequeridas: 0,
    items: 0,
  };

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private retoService: RetoService,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      url: [
        '',
        [
          Validators.required,
          Validators.maxLength(145),
          Validators.minLength(20),
          Validators.pattern(exp_invalidos),
        ],
      ],
    });
  }

  ngOnInit(): void {
    this.load(true, false);
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    this.cargarReto();
  }

  getRouteParams() {
    this.route.queryParams.subscribe((params) => {
      this.idReto = params['reto'];
      if (this.idReto === '' || !params['reto']) {
        history.back();
      }
    });
  }

  cargarReto() {
    this.retoService.getUsuario_RetoByIdUsuarioYIdReto(this.idReto).subscribe({
      next: (data: any) => {
        let { error, ur } = data.response;
        if (error === 0) {
          this.reto = ur.reto;

          let estado: number = 1;
          let fechaHoy = new Date();
          fechaHoy.setHours(0, 0, 0, 0);
          this.setFileType(this.reto.tipoArchivo);

          if (
            new Date(ur.reto.fechaApertura) >= fechaHoy &&
            this.dateCompare(ur.reto.fechaApertura) !== 'N/A'
          ) {
            estado = 0;
          }
          if (
            new Date(ur.reto.fechaCierre) < fechaHoy &&
            this.dateCompare(ur.reto.fechaCierre) !== 'N/A'
          ) {
            estado = 0;
          }

          if (estado === 0 || ur.reto.completado === 1) {
            this.router.navigate(['/user-reto']);
          }
        } else {
          this.router.navigate(['/user-reto']);
          this.load(false, false);
        }
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

  finalizar() {
    this.load(true, false);
    if (
      this.files.length === this.reto.items ||
      this.urlsVideos.length === this.reto.items
    ) {
      this.retoService
        .updateUsuario_retoRecoleccionPerdiente(this.setData())
        .subscribe({
          next: (data: any) => {
            let { error, info } = data.response;
            if (error === 0) {
              this.reproducirSonido(SoundQuizVictory);

              this.changeRoute('/fin-reto', { reto: this.idReto });
            } else {
              this.alertError(TitleErrorForm, info); //MsgErrorForm
            }
            this.load(false, false);
          },
          error: (e) => {
            console.error(e);
            if (e.status === 401 || e.status === 403) {
              this.router.navigate(['/']);
            } else {
              this.alertError(TitleError, MsgError);
              this.load(false, false);
            }
          },
        });
    } else {
      this.load(false, false);
      this.alertError(
        TitleErrorForm,
        'La cantidad de items a recoger es: ' + this.reto.items
      );
    }
  }

  setData(): FormData {
    let formData = new FormData();

    formData.append('idReto', this.idReto);

    if (this.files.length) {
      this.files.forEach((file) => {
        formData.append('files', file, file.name);
      });
    }

    if (this.urlsVideos.length) {
      formData.append('urlsVideos', JSON.stringify(this.urlsVideos));
    }

    return formData;
  }

  setFileType(tipo: string) {
    switch (tipo) {
      case 'Imagen/png jpg jpeg': {
        this.tipoArchivo = '.jpg, .jpeg, .png';
        this.sugerenciaArchivo = 'Tamaño máximo 200 KB. Formatos jpg y png.'; //Dimensiones máximas 360x360 píxeles y
        break;
      }
      case 'Excel': {
        this.tipoArchivo = '.xls, .xlsx';
        this.sugerenciaArchivo = 'Tamaño máximo 150 KB. Formatos xls y xlsx.';
        this.defaultImg = 'assets/img/default/file_excel.png';
        break;
      }
      case 'Word': {
        this.tipoArchivo = '.doc, .docx';
        this.sugerenciaArchivo = 'Tamaño máximo 150 KB. Formatos doc y docx.';
        this.defaultImg = 'assets/img/default/file_word.png';
        break;
      }
      case 'Pdf': {
        this.tipoArchivo = '.pdf';
        this.sugerenciaArchivo = 'Tamaño máximo 150 KB. Formato pdf.';
        this.defaultImg = 'assets/img/default/file_pdf.png';
        break;
      }
      case 'Texto': {
        this.tipoArchivo = '.txt, text/plain';
        this.sugerenciaArchivo = 'Tamaño máximo 150 KB. Formatos txt.';
        this.defaultImg = 'assets/img/default/file_text.png';
        break;
      }
      case 'Video': {
        this.tipoArchivo = 'url';
        this.sugerenciaArchivo = '';
        this.defaultImg = 'assets/img/default/file_video.png';
        this.headerDialog = 'Url Video';
        break;
      }
    }
  }

  onFileSelected(event: Event) {
    let selectedFiles: FileList = (event.target as HTMLInputElement).files!;

    if (selectedFiles.length) {
      this.responseFiles = [];
      for (let i = 0; i < selectedFiles.length; i++) {
        if (selectedFiles[i]) {
          let nameFile = selectedFiles[i].name.split('.');
          let extension = nameFile[nameFile.length - 1].toLowerCase();
          let reader = new FileReader();
          if (this.tipoArchivo.includes(extension)) {
            reader.onload = (e: any) => {
              switch (this.reto.tipoArchivo) {
                case 'Imagen/png jpg jpeg': {
                  let img = new Image();
                  img.src = e.target.result;
                  img.onload = () => {
                    /* let w = (img as HTMLImageElement).width;
                    let h = (img as HTMLImageElement).height; */

                    if (
                      selectedFiles[i].size > ImgSizeMax
                      /* || w > ImgWidthMax ||
                      h > ImgHeightMax */
                    ) {
                      this.responseFiles.push({
                        error: 1,
                        info: 'El archivo no puede superar los 200 KB.', //360x360 píxeles y los
                        id: selectedFiles[i].name,
                        campo: '',
                      });
                    } else if (!this.previewFiles.includes(img.src)) {
                      this.responseFiles.push({
                        error: 0,
                        info: 'Archivo agregado',
                        id: selectedFiles[i].name,
                        campo: '',
                      });

                      this.previewFiles.push(img.src);
                      this.files.push(selectedFiles[i]);
                    } else {
                      this.responseFiles.push({
                        error: 1,
                        info: 'El archivo ya fue agregado',
                        id: selectedFiles[i].name,
                        campo: '',
                      });
                    }
                  };
                  break;
                }
                case 'Texto':
                case 'Pdf':
                case 'Word':
                case 'Excel': {
                  if (selectedFiles[i].size > FileSizeMax) {
                    this.responseFiles.push({
                      error: 1,
                      info: 'El archivo no puede superar los 150 KB.',
                      id: selectedFiles[i].name,
                      campo: '',
                    });
                  } else if (
                    !this.itemYaAgregado(this.files, selectedFiles[i])
                  ) {
                    this.responseFiles.push({
                      error: 0,
                      info: 'Archivo agregado',
                      id: selectedFiles[i].name,
                      campo: '',
                    });

                    this.previewFiles.push(this.defaultImg);
                    this.files.push(selectedFiles[i]);
                  } else {
                    this.responseFiles.push({
                      error: 1,
                      info: 'El archivo ya fue agregado',
                      id: selectedFiles[i].name,
                      campo: '',
                    });
                  }
                  break;
                }
              }
            };
            reader.readAsDataURL(selectedFiles[i]);
          } else {
            this.responseFiles.push({
              error: 1,
              info: `No se permite el tipo del archivo .${extension}`,
              id: selectedFiles[i].name,
              campo: '',
            });
          }
        }
      }

      this.modal = true;
    }
  }

  agregarUrlVideo() {
    /* console.log(this.formulario.valid);
    console.log(this.formulario.value); */

    this.responseFiles = [];

    if (this.formulario.valid) {
      this.verErrorsInputs = false;

      let url = this.formulario.get(['url'])?.value;

      if (!this.urlVideoYaAgregado(this.urlsVideos, url)) {
        this.previewFiles.push(this.defaultImg);
        this.urlsVideos.push(url);
        this.limpiarInput();
      } else {
        this.alertError('Error', 'La url ya fue agregada');
      }
    } else {
      this.verErrorsInputs = true;
    }
  }

  itemYaAgregado(lista: File[], archivo: File) {
    return lista.some(
      (item) => item.name === archivo.name && item.size === archivo.size
    );
  }

  urlVideoYaAgregado(lista: string[], url: string) {
    return lista.some((item) => item === url);
  }

  deleteFile(index: number) {
    if (index < this.previewFiles.length) {
      this.previewFiles.splice(index, 1);

      if (this.tipoArchivo === 'url') {
        this.urlsVideos.splice(index, 1);
      } else {
        this.files.splice(index, 1);
      }
    }
  }

  limpiarInput() {
    if (this.fileInput) {
      this.fileInput.nativeElement.value = '';
    }
    this.formulario.patchValue({
      url: '',
    });
  }
}
