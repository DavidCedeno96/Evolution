import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { ConfigInicio } from 'src/app/Models/Configuracion';
import { CdkDragDrop, moveItemInArray } from '@angular/cdk/drag-drop';
import {
  AlertError,
  AlertWarning,
  Loading,
  MsgError,
  MsgOk,
  TitleError,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { ConfigInicioList } from 'src/app/Utils/DefaultLists';
import { HomeService } from 'src/app/services/home.service';

@Component({
  selector: 'app-inicio',
  templateUrl: './inicio.component.html',
  styleUrls: ['./inicio.component.css'],
  providers: [MessageService],
})
export class InicioComponent implements OnInit {
  alertWarning = AlertWarning();
  loading = Loading();
  alertError = AlertError();

  configIndexInicio: number = 0;
  estaGuardadoInicio: boolean = true;

  auxConfigInicioItems: ConfigInicio[] = ConfigInicioList;
  configInicioItems: ConfigInicio[] = [];

  configInicioItemsJug: ConfigInicio[] = [];
  configInicioItemsAdm: ConfigInicio[] = [];

  constructor(
    private homeService: HomeService,
    private messageService: MessageService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.loading(true, false);
    this.cargarInicio();
  }

  cargarInicio() {
    this.homeService.getList().subscribe({
      next: (data: any) => {
        let { error, info, lista } = data.response;
        if (error === 0) {
          lista.forEach((item: ConfigInicio) => {
            if (item.idRol === 'jug') {
              this.configInicioItemsJug.push(item);
            } else if (item.idRol === 'adm') {
              this.configInicioItemsAdm.push(item);
            }
          });
          this.configInicio(0, 'jug');
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
        }
      },
    });
  }

  configInicio(index: number, rol: string) {
    if (this.estaGuardadoInicio) {
      this.configIndexInicio = index;

      this.configInicioItems = this.auxConfigInicioItems.filter((item) => {
        item.color = '#FAFAFA';
        return item.idRol === rol;
      });
    } else {
      this.alertWarning(
        'Advertencia',
        'Cambios no guardados, por favor guarde los cambios antes de proceder'
      );
    }
  }

  updateInicio() {
    this.loading(true, false);
    let list: ConfigInicio[] = [];
    let idRol: string = '';
    if (this.configIndexInicio === 0) {
      for (let i = 0; i < this.configInicioItemsJug.length; i++) {
        this.configInicioItemsJug[i].indice = i + 1;
        this.configInicioItemsJug[i].color = '';
      }
      list = this.configInicioItemsJug;
      idRol = 'jug';
    } else if (this.configIndexInicio === 1) {
      for (let i = 0; i < this.configInicioItemsAdm.length; i++) {
        this.configInicioItemsAdm[i].indice = i + 1;
        this.configInicioItemsAdm[i].color = '';
      }
      list = this.configInicioItemsAdm;
      idRol = 'adm';
    }
    //console.log('Guardar las tarjetitas del Inicio', list);

    this.homeService.update(list, idRol).subscribe({
      next: (data: any) => {
        let { error, info } = data.response;
        if (error === 0) {
          this.messageService.add({
            severity: 'success',
            summary: MsgOk,
            detail: 'Configuración Guardada',
          });
        } else {
          this.alertError(TitleErrorForm, info);
        }
        this.estaGuardadoInicio = true;
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

  setColorItemAgregado(item: ConfigInicio): boolean {
    let itemAgregado: boolean = false;
    switch (this.configIndexInicio) {
      case 0: {
        this.configInicioItemsJug.forEach((ob) => {
          if (item.nombre === ob.nombre) {
            itemAgregado = true;
          }
        });
        break;
      }
      case 1: {
        this.configInicioItemsAdm.forEach((ob) => {
          if (item.nombre === ob.nombre) {
            itemAgregado = true;
          }
        });
        break;
      }
      default: {
        itemAgregado = false;
      }
    }
    return itemAgregado;
  }

  agregarItemInicio(item: ConfigInicio) {
    let itemAgregado: boolean = false;
    this.estaGuardadoInicio = true;

    if (item.idRol === 'jug') {
      itemAgregado =
        this.configInicioItemsJug.filter((ob) => {
          return ob.nombre === item.nombre;
        }).length > 0;

      if (!itemAgregado) {
        this.configInicioItemsJug.push(item);
        this.estaGuardadoInicio = false;
      }
    } else if (item.idRol === 'adm') {
      itemAgregado =
        this.configInicioItemsAdm.filter((ob) => {
          return ob.nombre === item.nombre;
        }).length > 0;

      if (!itemAgregado) {
        this.configInicioItemsAdm.push(item);
        this.estaGuardadoInicio = false;
      }
    }
  }

  onItemDrop(event: CdkDragDrop<ConfigInicio[]>): void {
    this.estaGuardadoInicio = false;

    if (this.configIndexInicio === 0) {
      moveItemInArray(
        this.configInicioItemsJug,
        event.previousIndex,
        event.currentIndex
      );
    } else if (this.configIndexInicio === 1) {
      moveItemInArray(
        this.configInicioItemsAdm,
        event.previousIndex,
        event.currentIndex
      );
    }
  }

  quitarItemInicio(item: ConfigInicio) {
    let itemAgregado: boolean = false;
    this.estaGuardadoInicio = false;

    if (item.idRol === 'jug') {
      itemAgregado =
        this.configInicioItemsJug.filter((ob) => {
          return ob.nombre === item.nombre;
        }).length > 0;

      if (itemAgregado) {
        this.configInicioItemsJug = this.configInicioItemsJug.filter(
          (ob) => ob != item
        );
      }
    } else if (item.idRol === 'adm') {
      itemAgregado =
        this.configInicioItemsAdm.filter((ob) => {
          return ob.nombre === item.nombre;
        }).length > 0;

      if (itemAgregado) {
        this.configInicioItemsAdm = this.configInicioItemsAdm.filter(
          (ob) => ob != item
        );
      }
    }
  }
}
