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
  SinRegistros,
  TitleErrorForm,
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

  @ViewChild('closeModal') closeModal!: ElementRef;

  first: number = 0;
  rows: number = 9; // items por página

  defaultFile: string = 'file_video.png';

  id: string = '';
  idUsuario: string = '';
  tipoArchivo: string = '';

  info: string = '';
  ur: Usuario_Reto[] = [];

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
  }

  getRouteParams() {
    this.route.queryParams.subscribe((params) => {
      let idReto = params['reto'];
      if (idReto === '' || !params['reto']) {
        history.back();
      }
      this.id = idReto;
    });
  }

  cargarData(idReto: string) {
    this.retoServicio.getRetosXValidarUsuarios(idReto).subscribe({
      next: (data: any) => {
        console.log(data);

        let { error, info, lista } = data.response;
        if (error === 0) {
          this.ur = lista;
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
          history.back();
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

  finalizar(puntos: number) {
    this.loading(true, false);
    this.retoServicio
      .updateUsuario_retoRecoleccionFinalizado(this.getFormData(), puntos)
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
            history.back();
          }
        },
      });
  }

  getFormData(): FormData {
    let formData = new FormData();
    formData.append('idReto', this.id);
    formData.append('idUsuario', this.idUsuario);

    return formData;
  }

  getArchivos(item: Usuario_Reto) {
    if (item.reto.tipoReto !== 'Comportamiento') {
      this.tipoArchivo = item.reto.tipoArchivo;
      this.archivos = item.archivos;
      this.idUsuario = item.usuario.idUsuario;

      this.defaultFile = this.setDefaultFile(item.reto.tipoArchivo);
    } else {
      this.changeRoute('/validar-comportamiento', {
        reto: item.reto.idReto,
        user: item.usuario.idUsuario,
      });
    }
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

  paginatedItems(): Usuario_Reto[] {
    const startIndex = this.first;
    const endIndex = startIndex + this.rows;
    return this.ur.slice(startIndex, endIndex);
  }

  totalItems(): number {
    return this.ur.length;
  }

  onPageChange(event: any) {
    this.first = event.first;
    this.rows = event.rows;
  }
}
