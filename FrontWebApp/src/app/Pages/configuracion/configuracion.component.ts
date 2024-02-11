import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { Area, Ciudad, Empresa, Pais } from 'src/app/Models/Adicional';
import { Configuracion } from 'src/app/Models/Configuracion';
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
import { exp_invalidos } from 'src/app/Utils/RegularExpressions';
import { AdicionalService } from 'src/app/services/adicional.service';
import { AreaService } from 'src/app/services/area.service';
import { CiudadService } from 'src/app/services/ciudad.service';
import { ConfiguracionService } from 'src/app/services/configuracion.service';
import { EmpresaService } from 'src/app/services/empresa.service';
import { PaisService } from 'src/app/services/pais.service';

@Component({
  selector: 'app-configuracion',
  templateUrl: './configuracion.component.html',
  styleUrls: ['./configuracion.component.css'],
  providers: [MessageService],
})
export class ConfiguracionComponent implements OnInit {
  alertError = AlertError();
  loading = Loading();
  getImage = GetImage();
  configIndex: number = 0;

  tituloModal: string = '';
  labelSelect: string = '';
  tipoCampo: string = '';
  tipoSubmitCampo: string = '';

  errorImgLogin: boolean = false;
  errorImgHeader: boolean = false;
  errorImgFooter: boolean = false;

  verErrorsInputsImage: boolean = false;
  verErrorsInputsCampo: boolean = false;

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

  configColores: Configuracion[] = [];
  configImages: Configuracion[] = [];

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
    private adicionalServicio: AdicionalService,
    private configuracionService: ConfiguracionService,
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
  }

  ngOnInit(): void {
    this.loading(true, false);
    this.cargarConfig();
    this.cargarCampos();
  }

  config(index: number) {
    this.configIndex = index;
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
        } else {
          this.alertError(TitleErrorForm, info);
        }
        this.loading(false, false);
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
    this.configuracionService.update(this.configColores).subscribe({
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

  onFileSelected(event: Event, tipo: string) {
    let selectedImage = (event.target as HTMLInputElement).files![0];

    switch (tipo) {
      case 'login': {
        this.imgLogin = selectedImage;

        if (selectedImage.size > ImgSizeMax) {
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

        if (selectedImage.size > ImgSizeMax) {
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

        if (selectedImage.size > ImgSizeMax) {
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
  }

  cambiarColor(e: Event, propiedad: string) {
    let selectedValue = (e.target as HTMLInputElement).value;
    let hostElement = this.el.nativeElement;
    hostElement.style.setProperty(propiedad, selectedValue);
  }
}
