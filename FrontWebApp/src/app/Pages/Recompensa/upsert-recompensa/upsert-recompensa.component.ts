import { AfterViewInit, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Categoria } from 'src/app/Models/Adicional';
import { Recompensa } from 'src/app/Models/Recompensa';
import {
  AlertError,
  ChangeRoute,
  GetImage,
  HtmlLicencias,
  ImgHeightMax,
  ImgSizeMax,
  ImgWidthMax,
  Loading,
  MsgError,
  MsgErrorForm,
  SetUpsert,
  SugerenciaImagen,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import {
  CaracterInvalid,
  exp_invalidos,
  exp_numeros,
} from 'src/app/Utils/RegularExpressions';
import { AdicionalService } from 'src/app/services/adicional.service';
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
  setUpsert = SetUpsert();
  changeRoute = ChangeRoute();
  caracterInvalid = CaracterInvalid();
  sugerenciaImagen = SugerenciaImagen;

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
    cantCanje: 0, //Son los Creditos Requeridos
    totalUsuarios: 0,
    idCategoria: '',
    categoria: '',
    estado: 0,
  };

  categorias: Categoria[] = [];

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private recompensaServicio: RecompensaService,
    private adicionalServicio: AdicionalService,
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
        //Son los Creditos Requeridos
        this.recompensa.cantCanje,
        [
          Validators.required,
          Validators.min(1),
          Validators.max(9999),
          Validators.pattern(exp_numeros),
        ],
      ],

      idCategoria: [this.recompensa.idCategoria, [Validators.required]],

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
        this.changeRoute('/404', {});
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
          this.changeRoute('/404', {});
          break;
        }
      }
    });

    this.cargarAdicionales();
  }

  cargarAdicionales() {
    this.adicionalServicio.getListRecompensa(1).subscribe({
      next: (data: any) => {
        let { categoriaRecompensaList } = data.response;
        this.categorias = categoriaRecompensaList.lista;

        if (this.type === 'crear') {
          var categoria = this.categorias.filter((obj) => {
            return obj.nombre === 'General';
          });

          this.formulario.patchValue({
            idCategoria: categoria[0].idCategoria,
          });
        }
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
          this.changeRoute('/404', {});
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
    this.recompensaServicio.create(this.getFormData()).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.setUpsert(true, 'Registro Creado');
          this.router.navigate(['/view-recompensa']);
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
    this.recompensaServicio.update(this.getFormData()).subscribe({
      next: (data: any) => {
        let { campo, error, info } = data.response;
        if (error === 0) {
          this.setUpsert(true, 'Registro Actualizado');
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
          this.changeRoute('/404', {});
        }
      },
    });
  }

  getFormData(): FormData {
    let formData = new FormData();
    formData.append('idRecompensa', this.recompensa.idRecompensa);
    formData.append('nombre', this.recompensa.nombre.trim());
    formData.append('idCategoria', this.recompensa.idCategoria.trim());
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
}
