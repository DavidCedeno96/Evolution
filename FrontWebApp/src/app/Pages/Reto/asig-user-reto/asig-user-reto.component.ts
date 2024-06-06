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
  ChangeRoute,
  GetImage,
  Loading,
  MsgEliminar,
  MsgElimindo,
  MsgError,
  MsgOk,
  SinRegistros,
  TitleEliminar,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { RetoService } from 'src/app/services/reto.service';
import { UsuarioService } from 'src/app/services/usuario.service';

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
  changeRoute = ChangeRoute();
  sinRegistros = SinRegistros;

  @ViewChild('closeModalAsignar') closeModalAsignar!: ElementRef;

  idReto: string = '';
  info: string = '';
  error: number = 0;
  verErrorsInputs: boolean = false;

  usuarios: Usuario[] = [];
  usuarioReto: Usuario_Reto[] = [];

  formulario!: FormGroup;

  constructor(
    private confirmationService: ConfirmationService,
    private messageService: MessageService,
    private usuarioServicio: UsuarioService,
    private route: ActivatedRoute,
    private router: Router,
    private retoServicio: RetoService,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      buscar: ['', [Validators.required]],
      correo: [
        '',
        [Validators.required, Validators.maxLength(99), Validators.email],
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
    this.retoServicio.getUsuario_RetoByIdReto(this.idReto, 0).subscribe({
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
          history.back();
        }
      },
    });
  }

  submitForm(event: any) {
    const botonClickeado = event.submitter.value;
    switch (botonClickeado) {
      case 'buscar': {
        this.setBuscar();
        break;
      }
      case 'asignar': {
        if (this.usuarios.length) {
          this.asignarUsuario();
        }
        break;
      }
      default: {
        this.loading(false, false);
        console.error('Error de para asignar');
        break;
      }
    }
  }

  setBuscar() {
    let buscar = this.formulario.get(['buscar'])?.value;
    if (buscar.trim() !== '') {
      this.loading(true, false);
      this.getUserBuscado(buscar);
    } else {
      this.usuarios = [];
    }
  }

  getUserBuscado(texto: string) {
    this.usuarioServicio.getBuscarList(texto).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        this.info = info;
        this.error = error;
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
          this.alertError(TitleError, MsgError);
        }
      },
    });
  }

  defaultList(event: Event) {
    let text = (event.target as HTMLInputElement).value;
    if (!text.trim()) {
      this.usuarios = [];
      this.error = 0;
      this.formulario.patchValue({ buscar: '', correo: '' });
    }
  }

  asignarUsuario() {
    if (this.formulario.valid) {
      this.loading(true, false);
      this.retoServicio.createUsuario_Reto(this.setData()).subscribe({
        next: (data: any) => {
          let { error, info } = data.response;
          if (error === 0) {
            this.messageService.add({
              severity: 'success',
              summary: MsgOk,
              detail: 'Usuario asignado al reto',
            });
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
      pais: '',
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
      idTipoEncuesta: '7c8c2672-2233-486a-a184-f0b51eb4a331',
      tipoEncuesta: '',
      idComportamiento: '7c8c2672-2233-486a-a184-f0b51eb4a331',
      comportamientoPregunta: '',
      idTipoArchivo: '7c8c2672-2233-486a-a184-f0b51eb4a331',
      tipoArchivo: '',
      idTipoValidador: '7c8c2672-2233-486a-a184-f0b51eb4a331',
      tipoValidador: '',
      estado: 0,
      totalPreguntas: 0,
      usuariosAsignados: 0,
      equiposAsignados: 0,
      validadores: 0,
      puedeValidar: 0,
      enEquipo: 0,
      opsRequeridas: 0,
      items: 0,
    };

    usuarioReto = {
      usuario: usuario,
      reto: reto,
      puntos: 0,
      tiempo: 0,
      vidas: 0,
      totalRetos: 0,
      posicion: 0,
      completado: 0,
      tieneEquipo: 0,
      archivos: [],
      correctas: 0,
      incorrectas: 0,
      fechaCreacion: new Date(),
      fechaModificacion: new Date(),
    };
    return usuarioReto!;
  }

  selectUsuario(correo: string) {
    this.formulario.patchValue({ correo: correo });
  }

  limpiarCampos() {
    this.closeModalAsignar.nativeElement.click();
    this.formulario.patchValue({ buscar: '', correo: '' });
    this.usuarios = [];
    this.verErrorsInputs = false;
  }
}
