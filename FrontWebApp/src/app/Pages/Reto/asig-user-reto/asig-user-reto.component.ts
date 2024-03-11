import {
  AfterViewInit,
  Component,
  ElementRef,
  OnInit,
  ViewChild,
} from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ConfirmationService, MessageService } from 'primeng/api';
import { Reto, Usuario_Reto } from 'src/app/Models/Reto';
import { Usuario } from 'src/app/Models/Usuario';
import {
  AlertError,
  GetImage,
  Loading,
  MsgEliminar,
  MsgElimindo,
  MsgError,
  MsgErrorArchivo,
  MsgFormatoDescargado,
  MsgOk,
  SinRegistros,
  TitleEliminar,
  TitleError,
  TitleErrorArchivo,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { RetoService } from 'src/app/services/reto.service';

@Component({
  selector: 'app-asig-user-reto',
  templateUrl: './asig-user-reto.component.html',
  styleUrls: ['./asig-user-reto.component.css'],
  providers: [ConfirmationService, MessageService],
})
export class AsigUserRetoComponent implements OnInit, AfterViewInit {
  loading = Loading();
  alertError = AlertError();
  getImage = GetImage();
  sinRegistros = SinRegistros;

  @ViewChild('closeModalAsignar') closeModalAsignar!: ElementRef;
  @ViewChild('closeModalImportar') closeModalImportar!: ElementRef;
  @ViewChild('valueArchivo') valueArchivo!: ElementRef;

  idReto: string = '';
  info: string = '';
  verErrorsInputs: boolean = false;

  selectedFile: File | null = null;
  errorArchivo: boolean = false;

  usuarioReto: Usuario_Reto[] = [];

  formulario!: FormGroup;

  constructor(
    private confirmationService: ConfirmationService,
    private messageService: MessageService,
    private route: ActivatedRoute,
    private router: Router,
    private retoServicio: RetoService,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      correo: [
        '',
        [Validators.required, Validators.maxLength(60), Validators.email],
      ],
    });
  }

  ngOnInit(): void {
    this.loading(true, false);
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    this.cargarData();
  }

  getRouteParams() {
    this.route.queryParams.subscribe((params) => {
      this.idReto = params['reto'];
      if (this.idReto === '' || !params['reto']) {
        history.back();
      }
    });
  }

  cargarData() {
    this.retoServicio.getUsuario_RetoByIdReto(this.idReto).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.usuarioReto = lista;
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

  onFileSelected(event: Event) {
    this.selectedFile = (event.target as HTMLInputElement).files![0];
    this.errorArchivo = false;
    console.log(this.selectedFile.name);
  }

  importArchivo() {
    if (this.selectedFile) {
      this.loading(true, false);
      this.errorArchivo = false;

      const formData = new FormData();
      formData.append('archivo', this.selectedFile);

      this.retoServicio.enviarArchivo(formData, this.idReto).subscribe({
        next: (data: any) => {
          const { info, error } = data.response;
          this.info = info;
          if (error === 0) {
            this.errorArchivo = false;
            this.limpiarCampos();
            this.cargarData();
            this.messageService.add({
              severity: 'success',
              summary: MsgOk,
              detail: 'Usuarios asignados al reto',
            });
          } else {
            this.errorArchivo = true;
          }
          this.loading(false, false);
        },
        error: (e) => {
          this.limpiarCampos();
          console.error(e);
          if (e.status === 401 || e.status === 403) {
            this.router.navigate(['/']);
          } else {
            this.loading(false, false);
            this.alertError(TitleErrorArchivo, MsgErrorArchivo);
          }
        },
      });
    } else {
      this.errorArchivo = true;
      this.info = 'Ingrese un archivo en formato .xlsx';
    }
  }

  exportArchivo() {
    this.loading(true, false);
    this.retoServicio.getArchivo().subscribe({
      next: (data: Blob) => {
        const urlObject = window.URL.createObjectURL(data);
        const element = document.createElement('a');
        element.download = `Formato de asignación de Usuarios.xlsx`;
        element.href = urlObject;
        element.click();
        this.loading(false, false);
        this.messageService.add({
          severity: 'success',
          summary: MsgOk,
          detail: MsgFormatoDescargado,
        });
      },
      error: (e) => {
        console.error(e);
        this.alertError(TitleError, MsgError);
        this.loading(false, false);
      },
    });
  }

  asignarUsuario() {
    if (this.formulario.valid) {
      this.loading(true, false);
      this.retoServicio.createUsuario_Reto(this.setData()).subscribe({
        next: (data: any) => {
          let { error, info } = data.response;
          if (error === 0) {
            this.limpiarCampos();
            this.cargarData();
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
      this.verErrorsInputs = true;
    }
  }

  confirmEliminar(idReto: string, idUsuario: string) {
    this.confirmationService.confirm({
      message: MsgEliminar,
      header: TitleEliminar,
      accept: () => this.eliminarUsuarioReto(idReto, idUsuario),
    });
  }

  eliminarUsuarioReto(idReto: string, idUsuario: string) {
    this.loading(true, false);
    this.retoServicio.deleteUsuarioReto(idReto, idUsuario).subscribe({
      next: (data: any) => {
        let { error, info } = data.response;
        if (error === 0) {
          this.messageService.add({
            severity: 'success',
            summary: MsgOk,
            detail: MsgElimindo,
          });
          this.cargarData();
        } else {
          this.loading(false, false);
          this.alertError(TitleError, info);
        }
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

  setData(): Usuario_Reto {
    let usuarioReto: Usuario_Reto;
    let usuario: Usuario;
    let reto: Reto;

    usuario = {
      idUsuario: '7c8c2672-2233-486a-a184-f0b51eb4a331',
      nombre: '',
      apellido: '',
      correo: this.formulario.get(['correo'])?.value,
      id: '',
      celular: '',
      foto: '',
      idRol: '',
      rol: '',
      idPais: '',
      idCiudad: '',
      ciudad: '',
      idEmpresa: '',
      empresa: '',
      idArea: '',
      area: '',
      contrasena: '',
      puntos: 0,
      creditos: 0,
      estado: 0,
    };

    reto = {
      idReto: this.idReto,
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
      idTipoReto: '7c8c2672-2233-486a-a184-f0b51eb4a331',
      tipoReto: '',
      idComportamiento: '7c8c2672-2233-486a-a184-f0b51eb4a331',
      comportamientoPregunta: '',
      estado: 0,
      totalPreguntas: 0,
    };

    usuarioReto = {
      usuario: usuario,
      reto: reto,
      puntos: 0,
      tiempo: 0,
      vidas: 0,
      totalRetos: 0,
      completado: 0,
    };
    return usuarioReto!;
  }

  limpiarCampos() {
    this.closeModalAsignar.nativeElement.click();
    this.closeModalImportar.nativeElement.click();
    this.selectedFile = null;
    this.valueArchivo.nativeElement.value = '';
    this.formulario.patchValue({ correo: '' });
    this.verErrorsInputs = false;
  }
}
