import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Area, Ciudad, Empresa, Pais } from 'src/app/Models/Adicional';
import {
  AlertError,
  Loading,
  MsgError,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { exp_invalidos } from 'src/app/Utils/RegularExpressions';
import { AdicionalService } from 'src/app/services/adicional.service';
import { AreaService } from 'src/app/services/area.service';
import { CiudadService } from 'src/app/services/ciudad.service';
import { EmpresaService } from 'src/app/services/empresa.service';
import { PaisService } from 'src/app/services/pais.service';

@Component({
  selector: 'app-campos',
  templateUrl: './campos.component.html',
  styleUrls: ['./campos.component.css'],
})
export class CamposComponent implements OnInit {
  loading = Loading();
  alertError = AlertError();

  @ViewChild('openModal') openModal!: ElementRef;
  @ViewChild('closeModal') closeModal!: ElementRef;
  @ViewChild('guardarCampo') guardarCampo!: ElementRef;

  tituloModal: string = '';
  labelSelect: string = '';
  tipoCampo: string = '';
  tipoSubmitCampo: string = '';
  verErrorsInputsCampo: boolean = false;

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

  formCampos!: FormGroup;

  constructor(
    private paisService: PaisService,
    private ciudadService: CiudadService,
    private empresaService: EmpresaService,
    private areaService: AreaService,
    private adicionalServicio: AdicionalService,
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
  }

  ngOnInit(): void {
    this.loading(true, false);
    this.cargarCampos();
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
}
