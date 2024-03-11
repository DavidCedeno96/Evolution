import {
  AfterViewInit,
  Component,
  ElementRef,
  OnInit,
  ViewChild,
} from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CdkDragDrop, moveItemInArray } from '@angular/cdk/drag-drop';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { Area, Ciudad, Empresa, Pais } from 'src/app/Models/Adicional';
import { ConfigInicio, Configuracion } from 'src/app/Models/Configuracion';
import {
  AlertError,
  GetImage,
  ImgSizeMaxConfig,
  Loading,
  MsgError,
  MsgErrorForm,
  MsgOk,
  SugerenciaImagenConfig,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { exp_invalidos } from 'src/app/Utils/RegularExpressions';
import { AdicionalService } from 'src/app/services/adicional.service';
import { AreaService } from 'src/app/services/area.service';
import { CiudadService } from 'src/app/services/ciudad.service';
import { ConfiguracionService } from 'src/app/services/configuracion.service';
import { EmpresaService } from 'src/app/services/empresa.service';
import { PaisService } from 'src/app/services/pais.service';
import { ConfigInicioList } from 'src/app/Utils/DefaultLists';
import { HomeService } from 'src/app/services/home.service';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-configuracion',
  templateUrl: './configuracion.component.html',
  styleUrls: ['./configuracion.component.css'],
  providers: [MessageService],
})
export class ConfiguracionComponent implements OnInit, AfterViewInit {
  alertError = AlertError();
  loading = Loading();
  getImage = GetImage();

  sugerenciaImagen = SugerenciaImagenConfig;
  configIndex: number = 0;
  configIndexInicio: number = 0;

  tituloModal: string = '';
  labelSelect: string = '';
  tipoCampo: string = '';
  tipoSubmitCampo: string = '';

  errorImgLogin: boolean = false;
  errorImgHeader: boolean = false;
  errorImgFooter: boolean = false;

  verErrorsInputsImage: boolean = false;
  verErrorsInputsCampo: boolean = false;

  idUsuario: string = '';

  imgLogin!: File;
  previewLogin: string = '';

  imgHeader!: File;
  previewHeader: string = '';

  imgFooter!: File;
  previewFooter: string = '';

  @ViewChild('openModal') openModal!: ElementRef;
  @ViewChild('closeModal') closeModal!: ElementRef;
  @ViewChild('guardarCampo') guardarCampo!: ElementRef;

  formColor!: FormGroup;
  formImages!: FormGroup;
  formCampos!: FormGroup;
  formCodigoRegistro!: FormGroup;

  configInicioItems: ConfigInicio[] = ConfigInicioList;
  configInicioItemsJug: ConfigInicio[] = [];
  configInicioItemsAdm: ConfigInicio[] = [];
  configColores: Configuracion[] = [];
  configImages: Configuracion[] = [];
  configLlave: Configuracion[] = [];

  paises: Pais[] = [];
  ciudades: Ciudad[] = [];
  empresas: Empresa[] = [];
  areas: Area[] = [];

  pais: Pais = {
    idPais: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: '',
    descripcion: '',
    estado: 0,
  };

  ciudad: Ciudad = {
    idCiudad: '',
    nombre: '',
    descripcion: '',
    idPais: '',
    pais: '',
    estado: 0,
  };

  empresa: Empresa = {
    idEmpresa: '',
    nombre: '',
    descripcion: '',
    estado: 0,
  };

  area: Area = {
    idArea: '',
    nombre: '',
    descripcion: '',
    idEmpresa: '',
    empresa: '',
    estado: 0,
  };

  constructor(
    private el: ElementRef,
    private messageService: MessageService,
    private paisService: PaisService,
    private ciudadService: CiudadService,
    private empresaService: EmpresaService,
    private areaService: AreaService,
    private usuarioService: UsuarioService,
    private adicionalServicio: AdicionalService,
    private configuracionService: ConfiguracionService,
    private homeService: HomeService,
    private router: Router,
    private formBuilder: FormBuilder
  ) {
    this.formCampos = this.formBuilder.group({
      idSelect: ['', [Validators.required]],
      nombre: [
        '',
        [
          Validators.required,
          Validators.maxLength(100),
          Validators.pattern(exp_invalidos),
        ],
      ],
      idCampo: [''],
    });

    this.formColor = this.formBuilder.group({
      bandaSuperior: [''],
      encabezado: [''],
      piePagina: [''],
      botonPrimario: [''],
      botonSecundario: [''],
      botonTerciario: [''],
      botonGuardado: [''],
      textoPrimario: [''],
      textoSecundario: [''],
      cargaSuperior: [''],
      cargaInferior: [''],
      menuItem: [''],
      menuItemHover: [''],
      textoMenuItem: [''],
      textoMenuItemActive: [''],
    });

    this.formImages = formBuilder.group({
      loginImage: [''],
      homeImage: [''],
      footerImage: [''],
    });

    this.formCodigoRegistro = formBuilder.group({
      llave: [
        '',
        [
          Validators.required,
          Validators.minLength(5),
          Validators.maxLength(50),
          Validators.pattern(exp_invalidos),
        ],
      ],
    });
  }

  ngOnInit(): void {
    this.loading(true, false);
    this.cargarConfig();
    this.cargarCampos();
    this.cargarInicio();
  }

  ngAfterViewInit(): void {
    this.idUsuario = this.usuarioService.getIdUsuario();
  }

  config(index: number) {
    this.configIndex = index;
  }

  configInicio(index: number, rol: string) {
    this.configIndexInicio = index;
    this.configInicioItems.forEach((item) => {
      item.idRol = rol;
      item.color = '#FAFAFA';
    });
  }

  cargarConfig() {
    this.configuracionService.getList().subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.configColores = lista.filter((item: Configuracion) => {
            return item.tipo === 'color';
          });

          this.configImages = lista.filter((item: Configuracion) => {
            return item.tipo === 'imagen';
          });

          this.configLlave = lista.filter((item: Configuracion) => {
            return item.tipo === 'llave';
          });

          this.formColor.patchValue({
            bandaSuperior: this.configColores[0].valor,
            encabezado: this.configColores[1].valor,
            piePagina: this.configColores[2].valor,
            botonPrimario: this.configColores[3].valor,
            botonSecundario: this.configColores[4].valor,
            botonTerciario: this.configColores[5].valor,
            botonGuardado: this.configColores[6].valor,
            textoPrimario: this.configColores[7].valor,
            textoSecundario: this.configColores[8].valor,
            cargaSuperior: this.configColores[9].valor,
            cargaInferior: this.configColores[10].valor,
            menuItem: this.configColores[11].valor,
            menuItemHover: this.configColores[12].valor,
            textoMenuItem: this.configColores[13].valor,
            textoMenuItemActive: this.configColores[14].valor,
          });

          this.formImages.patchValue({
            loginImage: this.configImages[0].valor,
            homeImage: this.configImages[1].valor,
            footerImage: this.configImages[2].valor,
          });

          this.formCodigoRegistro.patchValue({
            llave: this.configLlave[0].valor,
          });
        } else {
          this.alertError(TitleErrorForm, info);
        }
      },
      error: (e) => {
        console.error(e);
        this.alertError(TitleError, MsgError);
      },
    });
  }

  cargarCampos() {
    this.adicionalServicio.getListUsuario(-1).subscribe({
      next: (data: any) => {
        let { paisList, ciudadList, empresaList, areaList } = data.response;
        this.paises = paisList.lista;
        this.ciudades = ciudadList.lista;
        this.empresas = empresaList.lista;
        this.areas = areaList.lista;
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

  cargarInicio() {
    this.homeService.getList().subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          lista.forEach((item: ConfigInicio) => {
            if (item.idRol === 'jug') {
              this.configInicioItemsJug.push(item);
            } else if (item.idRol === 'adm') {
              this.configInicioItemsAdm.push(item);
            }
          });
          this.configInicio(0, 'jug');
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
          this.alertError(TitleError, MsgError);
        }
      },
    });
  }

  modalCampoUsuario(
    tipoCampo: string,
    tipoSubmitCampo: string,
    nombre: string,
    idSelect: string,
    id: string
  ) {
    this.tipoCampo = tipoCampo;
    this.tipoSubmitCampo = tipoSubmitCampo;
    this.verErrorsInputsCampo = false;
    this.formCampos.patchValue({
      idSelect: idSelect,
      nombre: nombre,
      idCampo: id,
    });
    this.openModal.nativeElement.click();
    switch (tipoCampo) {
      case 'pais': {
        this.tituloModal = 'Pais';
        this.labelSelect = '';
        break;
      }
      case 'ciudad': {
        this.tituloModal = 'Ciudad';
        this.labelSelect = 'Pais';
        break;
      }
      case 'empresa': {
        this.tituloModal = 'Empresa';
        this.labelSelect = '';
        break;
      }
      case 'area': {
        this.tituloModal = 'Área';
        this.labelSelect = 'Empresa';
        break;
      }
    }
  }

  upsertCampo() {
    if (this.formCampos.valid) {
      this.verErrorsInputsCampo = false;
      this.setDataCampo();

      this.loading(true, false);
      switch (this.tipoSubmitCampo) {
        case 'crear': {
          this.createCampo();
          break;
        }
        case 'editar': {
          this.updateCampo();
          break;
        }
      }
    } else {
      this.verErrorsInputsCampo = true;
    }
  }

  createCampo() {
    switch (this.tipoCampo) {
      case 'pais': {
        this.paisService.create(this.pais).subscribe({
          next: (data: any) => {
            let { campo, error, info } = data.response;
            if (error === 0) {
              this.closeModal.nativeElement.click();
              this.cargarCampos();
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
              this.alertError(TitleError, MsgError);
              this.loading(false, false);
            }
          },
        });
        break;
      }
      case 'ciudad': {
        this.ciudadService.create(this.ciudad).subscribe({
          next: (data: any) => {
            let { campo, error, info } = data.response;
            if (error === 0) {
              this.closeModal.nativeElement.click();
              this.cargarCampos();
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
              this.alertError(TitleError, MsgError);
              this.loading(false, false);
            }
          },
        });
        break;
      }
      case 'empresa': {
        this.empresaService.create(this.empresa).subscribe({
          next: (data: any) => {
            let { campo, error, info } = data.response;
            if (error === 0) {
              this.closeModal.nativeElement.click();
              this.cargarCampos();
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
              this.alertError(TitleError, MsgError);
              this.loading(false, false);
            }
          },
        });
        break;
      }
      case 'area': {
        this.areaService.create(this.area).subscribe({
          next: (data: any) => {
            let { campo, error, info } = data.response;
            if (error === 0) {
              this.closeModal.nativeElement.click();
              this.cargarCampos();
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
              this.alertError(TitleError, MsgError);
              this.loading(false, false);
            }
          },
        });
        break;
      }
    }
  }

  updateCampo() {
    switch (this.tipoCampo) {
      case 'pais': {
        this.paisService.update(this.pais).subscribe({
          next: (data: any) => {
            let { campo, error, info } = data.response;
            if (error === 0) {
              this.closeModal.nativeElement.click();
              this.cargarCampos();
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
              this.alertError(TitleError, MsgError);
              this.loading(false, false);
            }
          },
        });
        break;
      }
      case 'ciudad': {
        this.ciudadService.update(this.ciudad).subscribe({
          next: (data: any) => {
            let { campo, error, info } = data.response;
            if (error === 0) {
              this.closeModal.nativeElement.click();
              this.cargarCampos();
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
              this.alertError(TitleError, MsgError);
              this.loading(false, false);
            }
          },
        });
        break;
      }
      case 'empresa': {
        this.empresaService.update(this.empresa).subscribe({
          next: (data: any) => {
            let { campo, error, info } = data.response;
            if (error === 0) {
              this.closeModal.nativeElement.click();
              this.cargarCampos();
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
              this.alertError(TitleError, MsgError);
              this.loading(false, false);
            }
          },
        });
        break;
      }
      case 'area': {
        this.areaService.update(this.area).subscribe({
          next: (data: any) => {
            let { campo, error, info } = data.response;
            if (error === 0) {
              this.closeModal.nativeElement.click();
              this.cargarCampos();
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
              this.alertError(TitleError, MsgError);
              this.loading(false, false);
            }
          },
        });
        break;
      }
    }
  }

  updateImagen() {
    if (!this.errorImgLogin && !this.errorImgHeader && !this.errorImgFooter) {
      this.verErrorsInputsImage = false;
      this.loading(true, false);
      this.configuracionService.updateImages(this.setDataImagen()).subscribe({
        next: (data: any) => {
          let { error, info } = data.response;
          if (error === 0) {
            location.reload();
            //this.configIndex = 1;
          } else {
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
    } else {
      this.verErrorsInputsImage = true;

      this.alertError(TitleErrorForm, MsgErrorForm);
    }
  }

  updateColor() {
    this.loading(true, false);
    this.setDataColor();
    this.configuracionService.updateList(this.configColores).subscribe({
      next: (data: any) => {
        let { error, info } = data.response;
        if (error === 0) {
          location.reload();
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
          this.alertError(TitleError, MsgError);
          this.loading(false, false);
        }
      },
    });
  }

  updateInicio() {
    this.loading(true, false);
    let list: ConfigInicio[] = [];
    let idRol: string = '';
    if (this.configIndexInicio === 0) {
      for (let i = 0; i < this.configInicioItemsJug.length; i++) {
        this.configInicioItemsJug[i].indice = i + 1;
        this.configInicioItemsJug[i].color = '';
      }
      list = this.configInicioItemsJug;
      idRol = 'jug';
    } else if (this.configIndexInicio === 1) {
      for (let i = 0; i < this.configInicioItemsAdm.length; i++) {
        this.configInicioItemsAdm[i].indice = i + 1;
        this.configInicioItemsAdm[i].color = '';
      }
      list = this.configInicioItemsAdm;
      idRol = 'adm';
    }
    //console.log('Guardar las tarjetitas del Inicio', list);

    this.homeService.update(list, idRol).subscribe({
      next: (data: any) => {
        let { error, info } = data.response;
        if (error === 0) {
          this.messageService.add({
            severity: 'success',
            summary: MsgOk,
            detail: 'Configuración Guardada',
          });
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
          this.alertError(TitleError, MsgError);
          this.loading(false, false);
        }
      },
    });
  }

  updateCodigo() {
    if (this.formCodigoRegistro.valid) {
      this.loading(true, false);
      this.setDataCodigo();
      this.configuracionService.update(this.configLlave[0]).subscribe({
        next: (data: any) => {
          let { info, error } = data.response;
          if (error === 0) {
            this.messageService.add({
              severity: 'success',
              summary: MsgOk,
              detail: 'Configuración Guardada',
            });
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
            this.alertError(TitleError, MsgError);
            this.loading(false, false);
          }
        },
      });
    } else {
      this.alertError(TitleErrorForm, MsgErrorForm);
    }
  }

  onFileSelected(event: Event, tipo: string) {
    let selectedImage = (event.target as HTMLInputElement).files![0];

    switch (tipo) {
      case 'login': {
        this.imgLogin = selectedImage;

        if (selectedImage.size > ImgSizeMaxConfig) {
          this.errorImgLogin = true;
        } else {
          this.errorImgLogin = false;
        }

        if (selectedImage.size > 0) {
          let reader = new FileReader();
          reader.onload = (e: any) => {
            this.previewLogin = e.target.result;
          };
          reader.readAsDataURL(this.imgLogin);
        }
        break;
      }
      case 'header': {
        this.imgHeader = selectedImage;

        if (selectedImage.size > ImgSizeMaxConfig) {
          this.errorImgHeader = true;
        } else {
          this.errorImgHeader = false;
        }

        if (selectedImage.size > 0) {
          let reader = new FileReader();
          reader.onload = (e: any) => {
            this.previewHeader = e.target.result;
          };
          reader.readAsDataURL(this.imgHeader);
        }
        break;
      }
      case 'footer': {
        this.imgFooter = selectedImage;

        if (selectedImage.size > ImgSizeMaxConfig) {
          this.errorImgFooter = true;
        } else {
          this.errorImgFooter = false;
        }

        if (selectedImage.size > 0) {
          let reader = new FileReader();
          reader.onload = (e: any) => {
            this.previewFooter = e.target.result;
          };
          reader.readAsDataURL(this.imgFooter);
        }
        break;
      }
    }

    console.log(selectedImage.name);
  }

  setDataCampo() {
    let idSelect = this.formCampos.get(['idSelect'])?.value;
    let nombre = this.formCampos.get(['nombre'])?.value;
    let idCampo = this.formCampos.get(['idCampo'])?.value;

    this.pais.idPais = idSelect;
    this.pais.nombre = nombre;

    this.ciudad.idPais = idSelect;
    this.ciudad.idCiudad = idCampo;
    this.ciudad.nombre = nombre;

    this.empresa.idEmpresa = idSelect;
    this.empresa.nombre = nombre;

    this.area.idEmpresa = idSelect;
    this.area.idArea = idCampo;
    this.area.nombre = nombre;
  }

  setDataImagen(): FormData {
    let formData = new FormData();
    formData.append('jsonConfig', JSON.stringify(this.configImages));
    if (this.imgLogin) {
      formData.append('archivoLogin', this.imgLogin);
    }
    if (this.imgHeader) {
      formData.append('archivoHeader', this.imgHeader);
    }
    if (this.imgFooter) {
      formData.append('archivoFooter', this.imgFooter);
    }
    return formData;
  }

  setDataColor() {
    this.configColores[0].valor = this.formColor.get(['bandaSuperior'])?.value;
    this.configColores[1].valor = this.formColor.get(['encabezado'])?.value;
    this.configColores[2].valor = this.formColor.get(['piePagina'])?.value;
    this.configColores[3].valor = this.formColor.get(['botonPrimario'])?.value;
    this.configColores[4].valor = this.formColor.get([
      'botonSecundario',
    ])?.value;
    this.configColores[5].valor = this.formColor.get(['botonTerciario'])?.value;
    this.configColores[6].valor = this.formColor.get(['botonGuardado'])?.value;
    this.configColores[7].valor = this.formColor.get(['textoPrimario'])?.value;
    this.configColores[8].valor = this.formColor.get([
      'textoSecundario',
    ])?.value;
    this.configColores[9].valor = this.formColor.get(['cargaSuperior'])?.value;
    this.configColores[10].valor = this.formColor.get(['cargaInferior'])?.value;
    this.configColores[11].valor = this.formColor.get(['menuItem'])?.value;
    this.configColores[12].valor = this.formColor.get(['menuItemHover'])?.value;
    this.configColores[13].valor = this.formColor.get(['textoMenuItem'])?.value;
    this.configColores[14].valor = this.formColor.get([
      'textoMenuItemActive',
    ])?.value;

    this.configColores.forEach((item) => {
      item.idUsuario = this.idUsuario;
    });
  }

  setDataCodigo() {
    this.configLlave[0].valor = this.formCodigoRegistro.get(['llave'])?.value;
    this.configLlave[0].idUsuario = this.idUsuario;
  }

  cambiarColor(e: Event, propiedad: string) {
    let selectedValue = (e.target as HTMLInputElement).value;
    let hostElement = this.el.nativeElement;
    hostElement.style.setProperty(propiedad, selectedValue);
  }

  agregarItemInicio(item: ConfigInicio) {
    let itemAgregado: boolean = false;

    if (item.idRol === 'jug') {
      itemAgregado =
        this.configInicioItemsJug.filter((ob) => {
          return ob.nombre === item.nombre;
        }).length > 0;

      if (!itemAgregado) {
        this.configInicioItemsJug.push(item);
      }
    } else if (item.idRol === 'adm') {
      itemAgregado =
        this.configInicioItemsAdm.filter((ob) => {
          return ob.nombre === item.nombre;
        }).length > 0;

      if (!itemAgregado) {
        this.configInicioItemsAdm.push(item);
      }
    }
  }

  quitarItemInicio(item: ConfigInicio) {
    let itemAgregado: boolean = false;

    if (item.idRol === 'jug') {
      itemAgregado =
        this.configInicioItemsJug.filter((ob) => {
          return ob.nombre === item.nombre;
        }).length > 0;

      if (itemAgregado) {
        this.configInicioItemsJug = this.configInicioItemsJug.filter(
          (ob) => ob != item
        );
      }
    } else if (item.idRol === 'adm') {
      itemAgregado =
        this.configInicioItemsAdm.filter((ob) => {
          return ob.nombre === item.nombre;
        }).length > 0;

      if (itemAgregado) {
        this.configInicioItemsAdm = this.configInicioItemsAdm.filter(
          (ob) => ob != item
        );
      }
    }
  }

  onItemDrop(event: CdkDragDrop<ConfigInicio[]>): void {
    if (this.configIndexInicio === 0) {
      moveItemInArray(
        this.configInicioItemsJug,
        event.previousIndex,
        event.currentIndex
      );
    } else if (this.configIndexInicio === 1) {
      moveItemInArray(
        this.configInicioItemsAdm,
        event.previousIndex,
        event.currentIndex
      );
    }
  }

  calculateNewIndex(
    draggedElement: Element,
    freeDragPosition: { x: number; y: number }
  ): number {
    const elements = Array.from(draggedElement.parentElement!.children);
    const draggedIndex = elements.indexOf(draggedElement);
    const newIndex = Math.max(
      0,
      Math.min(
        elements.length,
        draggedIndex + freeDragPosition.x / draggedElement.clientWidth
      )
    );
    return Math.round(newIndex);
  }
}
