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
import { Nivel } from 'src/app/Models/Nivel';
import {
  AlertError,
  ChangeRoute,
  GetArchivo,
  GetImage,
  Loading,
  MsgArchivoDescargado,
  MsgEliminar,
  MsgElimindo,
  MsgError,
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
import { NivelService } from 'src/app/services/nivel.service';

@Component({
  selector: 'app-view-nivel',
  templateUrl: './view-nivel.component.html',
  styleUrls: ['./view-nivel.component.css'],
  providers: [ConfirmationService, MessageService],
})
export class ViewNivelComponent implements OnInit, AfterViewInit {
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

  formulario!: FormGroup;
  auxNivel: Nivel[] = [];

  nivel: Nivel[] = [
    {
      idNivel: '',
      nombre: '',
      descripcion: '',
      puntosNecesarios: 0,
      imagen: '',
      totalUsuarios: 0,
      estado: 0,
      fechaCreacion: new Date(),
    },
  ];

  constructor(
    private confirmationService: ConfirmationService,
    private messageService: MessageService,
    private nivelServicio: NivelService,
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
    this.nivelServicio.getList(-1).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.nivel = lista;
          this.auxNivel = lista;
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
          this.alertError(TitleError, MsgError);
          this.loading(false, false);
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
      this.nivel = this.auxNivel;
    }
  }

  getBuscar(texto: string) {
    this.nivelServicio.getBuscarList(texto).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.nivel = lista;
        } else {
          this.nivel = [];
          this.info = info;
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

  importArchivo() {
    if (this.selectedFile) {
      this.loading(true, false);
      this.errorArchivo = false;

      const formData = new FormData();
      formData.append('archivo', this.selectedFile);

      this.nivelServicio.enviarArchivo(formData).subscribe({
        next: (data: any) => {
          const { info, error } = data.response;
          this.info = info;
          if (error === 0) {
            this.errorArchivo = false;
            this.limpiarArchivo();
            this.cargarData();
            this.messageService.add({
              severity: 'success',
              summary: MsgOk,
              detail: 'Niveles creados',
            });
          } else {
            this.errorArchivo = true;
          }
          this.loading(false, false);
        },
        error: (e) => {
          this.limpiarArchivo();
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

  descargarArchivo() {
    this.loading(true, false);
    this.nivelServicio.getArchivo().subscribe({
      next: (data: Blob) => {
        const urlObject = window.URL.createObjectURL(data);
        const element = document.createElement('a');
        element.download = `Formato de Niveles.xlsx`;
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
        console.log(e);
      },
    });
  }

  exportarArchivo() {
    if (this.auxNivel.length) {
      this.loading(true, false);
      this.nivelServicio.reporteNivel(-1).subscribe({
        next: (data: any) => {
          let { info, error } = data.response;
          if (error === 0) {
            let url = this.getArchivo(info, 'Nivel');
            const element = document.createElement('a');
            element.download = `Niveles.xls`;
            element.href = url;
            element.click();

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
            this.loading(false, false);
            this.alertError(TitleErrorArchivo, MsgErrorArchivo);
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
    console.log(this.selectedFile.name);
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
    this.nivelServicio.delete(idReto).subscribe({
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

  defaultList(event: Event) {
    let text = (event.target as HTMLInputElement).value;
    if (!text.trim()) {
      this.nivel = this.auxNivel;
    }
  }

  limpiarArchivo() {
    this.closeModal.nativeElement.click();
    this.selectedFile = null;
    this.valueArchivo.nativeElement.value = '';
  }
}
