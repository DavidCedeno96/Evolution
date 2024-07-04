import {
  AfterViewInit,
  Component,
  ElementRef,
  OnInit,
  ViewChild,
} from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { Usuario } from 'src/app/Models/Usuario';
import { MessageService } from 'primeng/api';
import {
  AlertError,
  ChangeRoute,
  GetArchivo,
  GetImage,
  Loading,
  MsgActivado,
  MsgArchivoDescargado,
  MsgDesactivado,
  MsgErrorArchivo,
  MsgFormatoDescargado,
  MsgOk,
  SetUpsert,
  SinRegistros,
  TitleErrorArchivo,
  TitleErrorForm,
  Upsert,
  UpsertMsg,
} from 'src/app/Utils/Constants';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-view-user',
  templateUrl: './view-user.component.html',
  styleUrls: ['./view-user.component.css'],
  providers: [MessageService],
})
export class ViewUserComponent implements OnInit, AfterViewInit {
  alertError = AlertError();
  loading = Loading();
  changeRoute = ChangeRoute();
  getImage = GetImage();
  getArchivo = GetArchivo();
  setUpsert = SetUpsert();

  @ViewChild('closeModal') closeModal!: ElementRef;
  @ViewChild('valueArchivo') valueArchivo!: ElementRef;

  selectedFile: File | null = null;
  errorArchivo: boolean = false;

  info: string = '';
  infoArchivo: string = '';

  formulario!: FormGroup;

  auxUsuarios: Usuario[] = [];
  usuarios: Usuario[] = [];
  usuario: Usuario = {
    idUsuario: '',
    nombre: '',
    apellido: '',
    correo: '',
    id: '',
    paisCode: '',
    paisIso2: '',
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

  constructor(
    private messageService: MessageService,
    private usuarioServicio: UsuarioService,
    private router: Router,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      buscar: [''],
    });
  }

  ngOnInit(): void {
    this.loading(true, false);
    this.cargarData();
  }

  ngAfterViewInit(): void {
    if (Upsert) {
      setTimeout(() => {
        this.messageService.add({
          severity: 'success',
          summary: MsgOk,
          detail: UpsertMsg,
        });
        this.setUpsert(false, '');
      }, 100);
    }
  }

  cargarData() {
    this.usuarioServicio.getList(-1).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.usuarios = lista;
          this.auxUsuarios = lista;
          this.info = SinRegistros;
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

  submitBuscar() {
    let buscar = this.formulario.get(['buscar'])?.value;
    if (buscar.trim() !== '') {
      this.loading(true, false);
      this.getBuscar(buscar);
    } else {
      this.usuarios = this.auxUsuarios;
    }
  }

  getBuscar(texto: string) {
    this.usuarioServicio.getBuscarList(texto, 1).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.usuarios = lista;
        } else {
          this.usuarios = [];
          this.info = info;
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

  onFileSelected(event: Event) {
    this.selectedFile = (event.target as HTMLInputElement).files![0];
    this.errorArchivo = false;
  }

  importArchivo() {
    if (this.selectedFile) {
      this.loading(true, false);
      this.errorArchivo = false;

      const formData = new FormData();
      formData.append('archivo', this.selectedFile);

      this.usuarioServicio.enviarArchivo(formData).subscribe({
        next: (data: any) => {
          const { info, error } = data.response;
          this.infoArchivo = info;
          if (error === 0) {
            this.errorArchivo = false;
            this.limpiarArchivo(true);
            this.cargarData();
            this.messageService.add({
              severity: 'success',
              summary: MsgOk,
              detail: 'Usuarios Creados',
            });
          } else {
            this.errorArchivo = true;
          }
          this.loading(false, false);
        },
        error: (e) => {
          this.limpiarArchivo(true);
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
      this.infoArchivo = 'Ingrese un archivo en formato .xlsx';
    }
  }

  descargarArchivo() {
    this.loading(true, false);
    this.usuarioServicio.getArchivo().subscribe({
      next: (data: Blob) => {
        const urlObject = window.URL.createObjectURL(data);
        const element = document.createElement('a');
        element.download = `Formato de Usuarios.xlsx`;
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
        this.changeRoute('/404', {});
      },
    });
  }

  exportarArchivo() {
    if (this.auxUsuarios.length) {
      this.loading(true, false);
      this.usuarioServicio.reporteUsuarios(-1).subscribe({
        next: (data: any) => {
          let { info, error, file } = data.response;
          if (error === 0) {
            const byteArray = new Uint8Array(
              atob(file)
                .split('')
                .map((char) => char.charCodeAt(0))
            );

            const blob = new Blob([byteArray], {
              type: 'application/vnd.ms-excel',
            });

            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'Usuarios.xls';
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            window.URL.revokeObjectURL(url);

            this.messageService.add({
              severity: 'success',
              summary: MsgOk,
              detail: MsgArchivoDescargado,
            });
          } else {
            this.alertError(TitleErrorArchivo, info);
          }
          this.loading(false, false, 1000);
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
      this.alertError(TitleErrorArchivo, SinRegistros);
    }
  }

  setEstado(idUsuario: string, estado: number) {
    this.loading(true, false);
    this.usuario.idUsuario = idUsuario;
    this.usuario.estado = estado;

    this.usuarioServicio.updateEstado(this.usuario).subscribe({
      next: (data: any) => {
        let { error, info } = data.response;
        if (error === 0) {
          this.cargarData();
          this.messageService.add({
            severity: 'success',
            summary: MsgOk,
            detail: estado ? MsgActivado : MsgDesactivado,
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
          this.changeRoute('/404', {});
        }
      },
    });
  }

  defaultList(event: Event) {
    let text = (event.target as HTMLInputElement).value;
    if (!text.trim()) {
      this.usuarios = this.auxUsuarios;
    }
  }

  limpiarArchivo(closeModal: boolean) {
    if (closeModal) {
      this.closeModal.nativeElement.click();
    }
    this.selectedFile = null;
    this.valueArchivo.nativeElement.value = '';
  }
}
