import {
  AfterViewInit,
  Component,
  ElementRef,
  OnInit,
  ViewChild,
} from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { Usuario_Reto, UsuarioxArchivo } from 'src/app/Models/Reto';
import {
  AlertError,
  ChangeRoute,
  GetArchivo,
  GetImage,
  Loading,
  MsgArchivoDescargado,
  MsgOk,
  SetUpsert,
  SinRegistros,
  TitleErrorForm,
  Upsert,
  UpsertMsg,
} from 'src/app/Utils/Constants';
import { RetoService } from 'src/app/services/reto.service';

@Component({
  selector: 'app-validaciones-users',
  templateUrl: './validaciones-users.component.html',
  styleUrls: ['./validaciones-users.component.css'],
  providers: [MessageService],
})
export class ValidacionesUsersComponent implements OnInit, AfterViewInit {
  loading = Loading();
  alertError = AlertError();
  getImage = GetImage();
  getArchivo = GetArchivo();
  changeRoute = ChangeRoute();
  setUpsert = SetUpsert();

  @ViewChild('closeModal') closeModal!: ElementRef;

  defaultFile: string = 'file_video.png';
  expandirFileName: string = '';
  expandirFileIndex: number = 0;

  id: string = '';
  idUsuario: string = '';

  currentUserName: string = '';
  currentUserFoto: string = '';
  tipoArchivo: string = '';
  tipoReto: string = '';

  info: string = '';
  ur: Usuario_Reto[] = [];
  selectedUr: Usuario_Reto[] = [];

  archivos: UsuarioxArchivo[] = [];

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private retoServicio: RetoService,
    private messageService: MessageService
  ) {}

  ngOnInit(): void {
    this.loading(true, false);
    this.getRouteParams();
  }

  ngAfterViewInit(): void {
    this.cargarData(this.id);

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

  getRouteParams() {
    this.route.queryParams.subscribe((params) => {
      let idReto = params['reto'];
      if (idReto === '' || !params['reto']) {
        this.changeRoute('/404', {});
      }
      this.id = idReto;
    });
  }

  cargarData(idReto: string) {
    this.retoServicio.getRetosXValidarUsuarios(idReto).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.ur = lista;
          if (lista.length) {
            this.tipoReto = this.ur[0].reto.tipoReto;
          }

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

  exportArchivo(archivo: string) {
    this.loading(true, false);

    let fileUrl: string = this.getArchivo(archivo, 'Recoleccion');

    setTimeout(() => {
      const a = document.createElement('a');
      a.href = fileUrl;
      a.download = 'default.xlsx';
      a.style.display = 'none';
      document.body.appendChild(a);
      a.click();
      document.body.removeChild(a);
      this.loading(false, false);
      this.messageService.add({
        severity: 'success',
        summary: MsgOk,
        detail: MsgArchivoDescargado,
      });
    }, 1000);
  }

  exportZipArchivos() {
    this.loading(true, false);
    this.retoServicio.getZipArchivos(this.id, this.idUsuario).subscribe({
      next: (data: any) => {
        let { error, info, file } = data.response;
        if (error === 0) {
          const byteArray = new Uint8Array(
            atob(file)
              .split('')
              .map((char) => char.charCodeAt(0))
          );
          const blob = new Blob([byteArray], { type: 'application/zip' });
          const url = window.URL.createObjectURL(blob);
          const a = document.createElement('a');
          a.href = url;
          a.download = 'Archivos.zip';
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

  finalizar(puntos: number) {
    this.loading(true, false);
    this.retoServicio
      .updateUsuario_retoRecoleccionFinalizado(this.getFormData(false), puntos)
      .subscribe({
        next: (data: any) => {
          let { error, info } = data.response;
          if (error === 0) {
            this.closeModal.nativeElement.click();
            this.cargarData(this.id);
            this.messageService.add({
              severity: 'success',
              summary: MsgOk,
              detail: 'Usuario verificado',
            });
          } else {
            this.alertError(TitleErrorForm, info); //MsgErrorForm
            this.loading(false, false);
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

  finalizarMasivo(puntos: number) {
    this.loading(true, false);
    this.retoServicio
      .updateUsuario_retoRecoleccionFinalizadoMasivo(
        this.getFormData(true),
        puntos
      )
      .subscribe({
        next: (data: any) => {
          let { error, info } = data.response;
          if (error === 0) {
            this.cargarData(this.id);
            this.selectedUr = [];
            this.messageService.add({
              severity: 'success',
              summary: MsgOk,
              detail: 'Usuarios verificados',
            });
          } else {
            this.alertError(TitleErrorForm, info); //MsgErrorForm
            this.loading(false, false);
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

  getFormData(esMasivo: boolean): FormData {
    let formData = new FormData();
    formData.append('idReto', this.id);

    if (esMasivo) {
      let idsUsers: string[] = this.selectedUr.map(
        (item) => item.usuario.idUsuario
      );
      formData.append('idsUsuario', JSON.stringify(idsUsers));
    } else {
      formData.append('idUsuario', this.idUsuario);
    }

    return formData;
  }

  getArchivos(item: Usuario_Reto) {
    if (item.reto.tipoReto !== 'Comportamiento') {
      if (item.completado === 2) {
        this.tipoArchivo = item.reto.tipoArchivo;
        this.archivos = item.archivos;
      } else {
        this.archivos = [];
      }

      this.idUsuario = item.usuario.idUsuario;
      this.defaultFile = this.setDefaultFile(item.reto.tipoArchivo);
    } else if (item.totalOpsValidador === 0) {
      this.changeRoute('/validar-comportamiento', {
        reto: item.reto.idReto,
        user: item.usuario.idUsuario,
      });
    }
    this.currentUserName = `${item.usuario.nombre} ${item.usuario.apellido}`;
    this.currentUserFoto = item.usuario.foto;
  }

  setDefaultFile(tipo: string): string {
    switch (tipo) {
      case 'Excel': {
        return 'file_excel.png';
      }
      case 'Word': {
        return 'file_word.png';
      }
      case 'Pdf': {
        return 'file_pdf.png';
      }
      case 'Texto': {
        return 'file_text.png';
      }
      default: {
        return 'file_text.png';
      }
    }
  }

  getEstadoTexto(estado: number, totalOpsValidador: number): string {
    let msg: string = '';
    if (totalOpsValidador) {
      msg = 'Verificado';
    } else {
      switch (estado) {
        case 0: {
          msg = 'Pendiente de completar';
          break;
        }
        case 1: {
          msg = 'Verificado';
          break;
        }
        case 2: {
          msg = 'Pendiente de verificar';
          break;
        }
      }
    }

    return msg;
  }

  onSelectionChange(selection: any[]) {
    for (let i = selection.length - 1; i >= 0; i--) {
      let data = selection[i];
      if (data.completado === 1) {
        selection.splice(i, 1);
      }
    }
    this.selectedUr = selection;
  }

  setExpandirFile(archivo: string, index: number) {
    this.expandirFileName = archivo;
    this.expandirFileIndex = index;
  }
}
