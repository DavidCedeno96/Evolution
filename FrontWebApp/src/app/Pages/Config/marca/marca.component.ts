import { AfterViewInit, Component, ElementRef, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { Configuracion } from 'src/app/Models/Configuracion';
import {
  AlertError,
  ChangeRoute,
  GetImage,
  ImgSizeMaxConfig,
  Loading,
  MsgError,
  MsgErrorForm,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { ConfiguracionService } from 'src/app/services/configuracion.service';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-marca',
  templateUrl: './marca.component.html',
  styleUrls: ['./marca.component.css'],
})
export class MarcaComponent implements OnInit, AfterViewInit {
  loading = Loading();
  getImage = GetImage();
  alertError = AlertError();
  changeRoute = ChangeRoute();

  configIndex: number = 0;

  idUsuario: string = '';

  imgLogin!: File;
  previewLogin: string = '';

  imgHeader!: File;
  previewHeader: string = '';

  imgFooter!: File;
  previewFooter: string = '';

  hayCambiosImages: boolean = false;

  verErrorsInputsImage: boolean = false;

  errorImgLogin: boolean = false;
  errorImgHeader: boolean = false;
  errorImgFooter: boolean = false;

  verMarcaConfigAvanzada: boolean = false;

  configImages: Configuracion[] = [];
  configColores: Configuracion[] = [];

  formColor!: FormGroup;
  formImages!: FormGroup;

  constructor(
    private el: ElementRef,
    private configuracionService: ConfiguracionService,
    private usuarioService: UsuarioService,
    private router: Router,
    private formBuilder: FormBuilder
  ) {
    this.formColor = this.formBuilder.group({
      primario: [''],
      secundario: [''],
      terciario: [''],
      botonPrimario: [''],
      botonSecundario: [''],
      botonTerciario: [''],
      textoPrimario: [''],
      textoSecundario: [''],
      textoTerciario: [''],
      bandaSuperior: [''],
      encabezado: [''],
      piePagina: [''],
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
  }

  ngAfterViewInit(): void {
    this.idUsuario = this.usuarioService.getIdUsuario();
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

          /* this.configLlave = lista.filter((item: Configuracion) => {
            return item.tipo === 'llave';
          }); */

          this.formColor.patchValue({
            primario: this.configColores[0].valor,
            secundario: this.configColores[1].valor,
            terciario: this.configColores[2].valor,
            botonPrimario: this.configColores[3].valor,
            botonSecundario: this.configColores[4].valor,
            botonTerciario: this.configColores[5].valor,
            textoPrimario: this.configColores[6].valor,
            textoSecundario: this.configColores[7].valor,
            textoTerciario: this.configColores[8].valor,
            bandaSuperior: this.configColores[9].valor,
            encabezado: this.configColores[10].valor,
            piePagina: this.configColores[11].valor,
            cargaSuperior: this.configColores[12].valor,
            cargaInferior: this.configColores[13].valor,
            menuItem: this.configColores[14].valor,
            menuItemHover: this.configColores[15].valor,
            textoMenuItem: this.configColores[16].valor,
            textoMenuItemActive: this.configColores[17].valor,
          });

          this.formImages.patchValue({
            loginImage: this.configImages[0].valor,
            homeImage: this.configImages[1].valor,
            footerImage: this.configImages[2].valor,
          });

          /* this.formCodigoRegistro.patchValue({
            llave: this.configLlave[0].valor,
          }); */
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
          this.changeRoute('/404', {});
        }
      },
    });
  }

  cambiarColor(e: Event, tipo: string) {
    let selectedValue = (e.target as HTMLInputElement).value;
    switch (tipo) {
      case 'primario': {
        this.cambiarPropiedad(e, '--BotonPrimario');
        this.cambiarPropiedad(e, '--TextoPrimario');
        this.cambiarPropiedad(e, '--Loading1');
        this.cambiarPropiedad(e, '--BgMenuItem');
        this.formColor.patchValue({
          botonPrimario: selectedValue,
          textoPrimario: selectedValue,
          bandaSuperior: selectedValue,
          cargaSuperior: selectedValue,
          menuItem: selectedValue,
        });
        break;
      }
      case 'secundario': {
        this.cambiarPropiedad(e, '--BotonSecundario');
        this.cambiarPropiedad(e, '--TextoSecundario');
        this.cambiarPropiedad(e, '--Loading2');
        this.formColor.patchValue({
          botonSecundario: selectedValue,
          textoSecundario: selectedValue,
          encabezado: selectedValue,
          cargaInferior: selectedValue,
          textoMenuItem: selectedValue,
        });
        break;
      }
      case 'terciario': {
        this.cambiarPropiedad(e, '--BotonTerciario');
        this.cambiarPropiedad(e, '--TextoTerciario');
        this.cambiarPropiedad(e, '--BgMenuItem-hover');
        this.formColor.patchValue({
          botonTerciario: selectedValue,
          textoTerciario: selectedValue,
          piePagina: selectedValue,
          menuItemHover: selectedValue,
        });
        break;
      }
    }
    console.log(selectedValue, tipo);
  }

  cambiarPropiedad(e: Event, propiedad: string) {
    let selectedValue = (e.target as HTMLInputElement).value;
    let hostElement = this.el.nativeElement;
    hostElement.style.setProperty(propiedad, selectedValue);
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
            this.changeRoute('/404', {});
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
          this.changeRoute('/404', {});
        }
      },
    });
  }

  setDataColor() {
    this.configColores[0].valor = this.formColor.get(['primario'])?.value;
    this.configColores[1].valor = this.formColor.get(['secundario'])?.value;
    this.configColores[2].valor = this.formColor.get(['terciario'])?.value;
    this.configColores[3].valor = this.formColor.get(['botonPrimario'])?.value;
    this.configColores[4].valor = this.formColor.get([
      'botonSecundario',
    ])?.value;
    this.configColores[5].valor = this.formColor.get(['botonTerciario'])?.value;
    this.configColores[6].valor = this.formColor.get(['textoPrimario'])?.value;
    this.configColores[7].valor = this.formColor.get([
      'textoSecundario',
    ])?.value;
    this.configColores[8].valor = this.formColor.get(['textoTerciario'])?.value;
    this.configColores[9].valor = this.formColor.get(['bandaSuperior'])?.value;
    this.configColores[10].valor = this.formColor.get(['encabezado'])?.value;
    this.configColores[11].valor = this.formColor.get(['piePagina'])?.value;
    this.configColores[12].valor = this.formColor.get(['cargaSuperior'])?.value;
    this.configColores[13].valor = this.formColor.get(['cargaInferior'])?.value;
    this.configColores[14].valor = this.formColor.get(['menuItem'])?.value;
    this.configColores[15].valor = this.formColor.get(['menuItemHover'])?.value;
    this.configColores[16].valor = this.formColor.get(['textoMenuItem'])?.value;
    this.configColores[17].valor = this.formColor.get([
      'textoMenuItemActive',
    ])?.value;

    /* this.configColores.forEach((item) => {
      item.idUsuario = this.idUsuario;
    }); */
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

  onFileSelected(
    event: Event,
    tipo: string,
    widthMax: number,
    heightMax: number
  ) {
    let selectedImage = (event.target as HTMLInputElement).files![0];
    if (selectedImage) {
      this.hayCambiosImages = true;
    }

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
        console.log(selectedImage);

        if (selectedImage) {
          let reader = new FileReader();
          reader.onload = (e: any) => {
            let img = new Image();
            img.src = e.target.result;
            img.onload = () => {
              let w = (img as HTMLImageElement).width;
              let h = (img as HTMLImageElement).height;

              if (
                selectedImage.size > ImgSizeMaxConfig ||
                w > widthMax ||
                h > heightMax
              ) {
                this.errorImgHeader = true;
              } else {
                this.errorImgHeader = false;
              }
            };
            this.previewHeader = img.src;
          };
          reader.readAsDataURL(this.imgHeader);
        }

        break;
      }
      case 'footer': {
        this.imgFooter = selectedImage;

        if (selectedImage) {
          let reader = new FileReader();
          reader.onload = (e: any) => {
            let img = new Image();
            img.src = e.target.result;
            img.onload = () => {
              let w = (img as HTMLImageElement).width;
              let h = (img as HTMLImageElement).height;

              if (
                selectedImage.size > ImgSizeMaxConfig ||
                w > widthMax ||
                h > heightMax
              ) {
                this.errorImgFooter = true;
              } else {
                this.errorImgFooter = false;
              }
            };
            this.previewFooter = img.src;
          };
          reader.readAsDataURL(this.imgFooter);
        }
        break;
      }
    }

    //console.log(selectedImage.name);
  }

  config(index: number) {
    this.configIndex = index;
  }
}
