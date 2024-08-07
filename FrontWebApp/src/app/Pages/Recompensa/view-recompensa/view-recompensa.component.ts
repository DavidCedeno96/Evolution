import {
  AfterViewInit,
  Component,
  ElementRef,
  OnInit,
  ViewChild,
} from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { ConfirmationService, MessageService } from 'primeng/api';
import { Recompensa } from 'src/app/Models/Recompensa';
import {
  AlertError,
  ChangeRoute,
  GetArchivo,
  GetImage,
  Loading,
  MsgActivado,
  MsgArchivoDescargado,
  MsgDesactivado,
  MsgEliminar,
  MsgElimindo,
  MsgErrorArchivo,
  MsgFormatoDescargado,
  MsgOk,
  SetUpsert,
  SinRegistros,
  TitleEliminar,
  TitleError,
  TitleErrorArchivo,
  TitleErrorForm,
  Upsert,
  UpsertMsg,
} from 'src/app/Utils/Constants';
import { RecompensaService } from 'src/app/services/recompensa.service';

@Component({
  selector: 'app-view-recompensa',
  templateUrl: './view-recompensa.component.html',
  styleUrls: ['./view-recompensa.component.css'],
  providers: [ConfirmationService, MessageService],
})
export class ViewRecompensaComponent implements OnInit, AfterViewInit {
  alertError = AlertError();
  loading = Loading();
  setUpsert = SetUpsert();
  changeRoute = ChangeRoute();
  getImage = GetImage();
  getArchivo = GetArchivo();

  @ViewChild('closeModal') closeModal!: ElementRef;
  @ViewChild('valueArchivo') valueArchivo!: ElementRef;

  selectedFile: File | null = null;
  errorArchivo: boolean = false;

  info: string = '';
  infoArchivo: string = '';

  formulario!: FormGroup;
  auxRecompensas: Recompensa[] = [];

  recompensas: Recompensa[] = [];
  recompensa: Recompensa = {
    idRecompensa: '',
    nombre: '',
    descripcion: '',
    imagen: '',
    cantDisponible: 0,
    cantCanje: 0, // Son los Créditos Requeridos
    totalUsuarios: 0,
    idCategoria: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    categoria: '',
    estado: 0,
  };

  constructor(
    private confirmationService: ConfirmationService,
    private messageService: MessageService,
    private recompensaServicio: RecompensaService,
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
    this.recompensaServicio.getList(-1).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.recompensas = lista;
          this.auxRecompensas = lista;
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
      this.recompensas = this.auxRecompensas;
    }
  }

  getBuscar(texto: string) {
    this.recompensaServicio.getBuscarList(texto, '').subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.recompensas = lista;
        } else {
          this.recompensas = [];
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

  importArchivo() {
    if (this.selectedFile) {
      this.loading(true, false);
      this.errorArchivo = false;

      const formData = new FormData();
      formData.append('archivo', this.selectedFile);

      this.recompensaServicio.enviarArchivo(formData).subscribe({
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
              detail: 'Recompensas creadas',
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
    this.recompensaServicio.getArchivo().subscribe({
      next: (data: Blob) => {
        const urlObject = window.URL.createObjectURL(data);
        const element = document.createElement('a');
        element.download = `Formato de Recompensas.xlsx`;
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
        if (e.status === 401 || e.status === 403) {
          this.router.navigate(['/']);
        } else {
          this.changeRoute('/404', {});
        }
      },
    });
  }

  exportarArchivo() {
    if (this.auxRecompensas.length) {
      this.loading(true, false);
      this.recompensaServicio.reporteRecompensa(-1).subscribe({
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
            a.download = 'Recompensas.xls';
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

  onFileSelected(event: Event) {
    this.selectedFile = (event.target as HTMLInputElement).files![0];
    this.errorArchivo = false;
  }

  setEstado(idRecompensa: string, estado: number) {
    this.loading(true, false);
    this.recompensa.idRecompensa = idRecompensa;
    this.recompensa.estado = estado;

    this.recompensaServicio.updateEstado(this.recompensa).subscribe({
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

  confirmEliminar(id: string) {
    this.confirmationService.confirm({
      message: MsgEliminar,
      header: TitleEliminar,
      accept: () => this.eliminar(id),
    });
  }

  eliminar(idReto: string) {
    this.loading(true, false);
    this.recompensaServicio.delete(idReto).subscribe({
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

  defaultList(event: Event) {
    let text = (event.target as HTMLInputElement).value;
    if (!text.trim()) {
      this.recompensas = this.auxRecompensas;
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
