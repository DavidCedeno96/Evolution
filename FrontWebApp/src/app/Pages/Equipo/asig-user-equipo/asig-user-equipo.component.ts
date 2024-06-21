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
import { Equipo, Usuario_Equipo } from 'src/app/Models/Equipo';
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
import { EquipoService } from 'src/app/services/equipo.service';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-asig-user-equipo',
  templateUrl: './asig-user-equipo.component.html',
  styleUrls: ['./asig-user-equipo.component.css'],
  providers: [ConfirmationService, MessageService],
})
export class AsigUserEquipoComponent implements OnInit, AfterViewInit {
  loading = Loading();
  alertError = AlertError();
  getImage = GetImage();
  changeRoute = ChangeRoute();
  sinRegistros = SinRegistros;

  @ViewChild('closeModalAsignar') closeModalAsignar!: ElementRef;

  idEquipo: string = '';
  info: string = '';
  error: number = 0;
  verErrorsInputs: boolean = false;

  usuarios: Usuario[] = [];
  usuarioEquipo: Usuario_Equipo[] = [];

  formulario!: FormGroup;

  constructor(
    private confirmationService: ConfirmationService,
    private messageService: MessageService,
    private usuarioServicio: UsuarioService,
    private route: ActivatedRoute,
    private router: Router,
    private equipoServicio: EquipoService,
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
      this.idEquipo = params['equipo'];
      if (this.idEquipo === '' || !params['equipo']) {
        this.changeRoute('/404', {});
      }
    });
  }

  cargarData() {
    this.equipoServicio.getUsuario_EquipoByIdEquipo(this.idEquipo).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.usuarioEquipo = lista;
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
          this.changeRoute('/404', {});
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
      this.equipoServicio.createUsuario_Equipo(this.setData()).subscribe({
        next: (data: any) => {
          let { error, info } = data.response;
          if (error === 0) {
            this.messageService.add({
              severity: 'success',
              summary: MsgOk,
              detail: 'Usuario asignado al equipo',
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
            this.changeRoute('/404', {});
          }
        },
      });
    } else {
      this.verErrorsInputs = true;
    }
  }

  confirmEliminar(idEquipo: string, idUsuario: string) {
    this.confirmationService.confirm({
      message: MsgEliminar,
      header: TitleEliminar,
      accept: () => this.eliminarUsuarioEquipo(idEquipo, idUsuario),
    });
  }

  eliminarUsuarioEquipo(idEquipo: string, idUsuario: string) {
    this.loading(true, false);
    this.equipoServicio.deleteUsuarioEquipo(idEquipo, idUsuario).subscribe({
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
          this.changeRoute('/404', {});
        }
      },
    });
  }

  setData(): Usuario_Equipo {
    let usuarioEquipo: Usuario_Equipo;
    let usuario: Usuario;
    let equipo: Equipo;

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

    equipo = {
      idEquipo: this.idEquipo,
      nombre: '',
      imagen: '',
      descripcion: '',
      totalUsuarios: 0,
      puntos: 0,
      tiempo: 0,
      estado: 0,
    };

    usuarioEquipo = {
      usuario: usuario,
      equipo: equipo,
      posicion: 0,
      fechaCreacion: new Date(),
      fechaModificacion: new Date(),
    };
    return usuarioEquipo!;
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
