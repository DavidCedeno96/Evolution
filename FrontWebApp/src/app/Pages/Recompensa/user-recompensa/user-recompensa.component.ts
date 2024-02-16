import {
  AfterViewInit,
  Component,
  ElementRef,
  OnInit,
  ViewChild,
} from '@angular/core';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { Recompensa, Usuario_Recompensa } from 'src/app/Models/Recompensa';
import { Usuario } from 'src/app/Models/Usuario';
import {
  AlertError,
  GetImage,
  Loading,
  MsgError,
  MsgOk,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
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
  loading = Loading();

  @ViewChild('closeModal') closeModal!: ElementRef;

  errorCreditos: boolean = false;
  errorCantDisp: boolean = false;

  recomensas: Recompensa[] = [];
  recomensa: Recompensa = {
    idRecompensa: '',
    nombre: '',
    descripcion: '',
    imagen: '',
    cantDisponible: 0,
    cantCanje: 0,
    totalUsuarios: 0,
    estado: 0,
  };

  usuario: Usuario = {
    idUsuario: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: '',
    apellido: '',
    correo: '',
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

  constructor(
    private recompensaService: RecompensaService,
    private router: Router,
    private messageService: MessageService
  ) {}

  ngOnInit(): void {
    this.loading(true, false);
  }

  ngAfterViewInit(): void {
    this.cargarData();
  }

  cargarData() {
    this.recompensaService.getList(-1).subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        let errorUser = data.responseUser.error;
        let infoUser = data.responseUser.info;
        let usuario = data.responseUser.usuario;

        if (error === 0) {
          lista.forEach((item: Recompensa) => {
            if (item.cantDisponible === 0) {
              item.estado = 0;
            }
          });
          this.recomensas = lista;
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
            this.messageService.add({
              severity: 'success',
              summary: MsgOk,
              detail: 'Recopmansa Reclamada',
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
}
