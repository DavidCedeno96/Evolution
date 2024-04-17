import {
  AfterViewInit,
  Component,
  ElementRef,
  OnInit,
  ViewChild,
} from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { Categoria } from 'src/app/Models/Adicional';
import { Recompensa, Usuario_Recompensa } from 'src/app/Models/Recompensa';
import { Usuario } from 'src/app/Models/Usuario';
import {
  AlertError,
  AlertSuccess,
  GetImage,
  Loading,
  MsgError,
  MsgOk,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { AdicionalService } from 'src/app/services/adicional.service';
import { RecompensaService } from 'src/app/services/recompensa.service';

@Component({
  selector: 'app-user-recompensa',
  templateUrl: './user-recompensa.component.html',
  styleUrls: ['./user-recompensa.component.css'],
  providers: [MessageService],
})
export class UserRecompensaComponent implements OnInit, AfterViewInit {
  getImage = GetImage();
  alertError = AlertError();
  alertSuccess = AlertSuccess();
  loading = Loading();

  @ViewChild('closeModal') closeModal!: ElementRef;

  first: number = 0;
  rows: number = 6; // items por página

  info: string = '';

  errorCreditos: boolean = false;
  errorCantDisp: boolean = false;

  categorias: Categoria[] = [];
  recomensas: Recompensa[] = [];
  auxRecomensas: Recompensa[] = [];
  recomensa: Recompensa = {
    idRecompensa: '',
    nombre: '',
    descripcion: '',
    imagen: '',
    cantDisponible: 0,
    cantCanje: 0, // Son los Créditos requeridos
    totalUsuarios: 0,
    idCategoria: '',
    categoria: '',
    estado: 0,
  };

  usuario: Usuario = {
    idUsuario: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: '',
    apellido: '',
    correo: '',
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

  formulario!: FormGroup;

  constructor(
    private recompensaService: RecompensaService,
    private router: Router,
    private messageService: MessageService,
    private adicionalServicio: AdicionalService,
    private formBuilder: FormBuilder
  ) {
    this.formulario = this.formBuilder.group({
      buscar: [''],
      idCategoria: [''],
    });
  }

  ngOnInit(): void {
    this.loading(true, false);
  }

  ngAfterViewInit(): void {
    this.cargarData();
  }

  cargarData() {
    this.recompensaService.getList(1).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        let errorUser = data.responseUser.error;
        let infoUser = data.responseUser.info;
        let usuario = data.responseUser.usuario;

        if (error === 0) {
          this.recomensas = lista;
          this.auxRecomensas = lista;
          this.cargarAdicionales();
        } else {
          this.alertError(TitleErrorForm, info);
        }

        if (errorUser === 0) {
          this.usuario = usuario;
        } else {
          this.alertError(TitleErrorForm, infoUser);
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

  cargarAdicionales() {
    this.adicionalServicio.getListRecompensa(1).subscribe({
      next: (data: any) => {
        let { categoriaRecompensaList } = data.response;
        this.categorias = categoriaRecompensaList.lista;
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

  canjear(item: Recompensa) {
    if (this.usuario.creditos < item.cantCanje) {
      this.errorCreditos = true;
    } else if (item.cantDisponible < 1) {
      this.errorCantDisp = true;
    } else {
      this.loading(true, false);
      this.errorCreditos = false;
      let usuario_recompensa: Usuario_Recompensa = {
        idRecompensa: item.idRecompensa,
        idUsuario: this.usuario.idUsuario,
      };
      this.recompensaService.cajearRecompensa(usuario_recompensa).subscribe({
        next: (data: any) => {
          let { error, info } = data.response;
          if (error === 0) {
            this.usuario.creditos -= item.cantCanje;
            this.recomensas.forEach((element) => {
              if (element.idRecompensa === item.idRecompensa) {
                element.cantDisponible -= 1;
              }
            });

            this.closeModal.nativeElement.click();

            this.alertSuccess(
              'Recompensa Canjeada',
              `<div>
                <h6>
                  ${
                    info.includes('correo')
                      ? 'Has Canjeado correctamente la recompensa, hemos enviado a tu correo las instrucciones para que puedas reclamar tu recompensa'
                      : 'Has Canjeado correctamente la recompensa!'
                  }                  
                </h6>                                
                ${
                  info.includes('correo')
                    ? '<small>Si no recibiste el correo revisa el correo no deseado</small>'
                    : ''
                }
              </div>`
            );

            /* this.messageService.add({
              severity: 'success',
              summary: MsgOk,
              detail: 'Recopmansa Reclamada',
            }); */
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
  }

  selectRecompensa(item: Recompensa) {
    this.errorCreditos = false;
    this.recomensa = item;
  }

  submitBuscar() {
    let buscar = this.formulario.get(['buscar'])?.value;
    if (buscar.trim() !== '') {
      this.loading(true, false);
      this.getBuscar(buscar);
    } else {
      this.recomensas = this.auxRecomensas;
    }
  }

  getBuscar(texto: string) {
    let idCategoria = this.formulario.get(['idCategoria'])?.value;
    this.recompensaService.getBuscarList(texto, idCategoria).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.recomensas = lista;
        } else {
          this.recomensas = [];
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

  filtrar(event: Event) {
    let value: string = (event.target as HTMLSelectElement).value;
    let texto = this.formulario.get(['buscar'])?.value.trim();
    if (value.trim()) {
      this.formulario.patchValue({
        idCategoria: value,
      });
      this.loading(true, false);
      this.getBuscar(texto);
    } else if (!texto.trim()) {
      this.recomensas = this.auxRecomensas;
    }
  }

  defaultList(event: Event) {
    let text = (event.target as HTMLInputElement).value;
    let idCategoria = this.formulario.get(['idCategoria'])?.value;
    if (!text.trim() && !idCategoria.trim()) {
      this.recomensas = this.auxRecomensas;
    } else if (!text.trim() && idCategoria.trim()) {
      this.formulario.patchValue({
        idCategoria: idCategoria,
      });
      this.loading(true, false);
      this.getBuscar(text);
    }
  }

  getEstadoCantItems(cantidad: number): boolean {
    if (cantidad > 0) {
      return true;
    } else {
      return false;
    }
  }

  paginatedItems(): Recompensa[] {
    const startIndex = this.first;
    const endIndex = startIndex + this.rows;
    return this.recomensas.slice(startIndex, endIndex);
  }

  totalItems(): number {
    return this.recomensas.length;
  }

  onPageChange(event: any) {
    this.first = event.first;
    this.rows = event.rows;
  }
}
