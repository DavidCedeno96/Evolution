import {
  Component,
  ElementRef,
  EventEmitter,
  Input,
  Output,
  ViewChild,
} from '@angular/core';
import { Router } from '@angular/router';
import { Novedad } from 'src/app/Models/Novedad';
import {
  AlertError,
  ChangeRoute,
  DateCompare,
  Loading,
  TitleErrorForm,
} from 'src/app/Utils/Constants';
import { NovedadService } from 'src/app/services/novedad.service';

@Component({
  selector: 'app-novedades',
  templateUrl: './novedades.component.html',
  styleUrls: ['./novedades.component.css'],
})
export class NovedadesComponent {
  changeRoute = ChangeRoute();
  dateCompare = DateCompare();
  alertError = AlertError();
  load = Loading();

  @Input() novedades: Novedad[] = [];
  @Output() numItem: EventEmitter<{ value: number; eliminarTodo: boolean }> =
    new EventEmitter<{ value: number; eliminarTodo: boolean }>();

  //@Output() notify: EventEmitter<{ message: string, value: number }> = new EventEmitter<{ message: string, value: number }>();

  @ViewChild('closeModal') closeModal!: ElementRef;

  constructor(private router: Router, private novedadService: NovedadService) {}

  /* cargarNovedad() {
    this.novedadService.getList().subscribe({
      next: (data: any) => {
        console.log(data);
        let { error, info, lista } = data.response;
        if (error === 0) {
          this.novedades = lista;
        } else {
          this.alertError(TitleErrorForm, info);
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
  } */

  marcar(item: Novedad, estado: number) {
    const obj = this.novedades.find((ob) => ob === item);

    if (obj) {
      obj.estado = estado;
      this.load(true, false);
      this.novedadService.updateEstado(obj).subscribe({
        next: (data: any) => {
          console.log(data);

          let { error, info } = data.response;
          if (error === 0) {
            if (estado) {
              this.numItem.emit({ value: 1, eliminarTodo: false });
            } else {
              this.numItem.emit({ value: -1, eliminarTodo: false });
            }
          } else {
            this.alertError(TitleErrorForm, info);
          }
          this.load(false, false);
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
  }

  acceder(item: Novedad) {
    this.closeModal.nativeElement.click();
    let currentPath = this.router.url.split('?')[0];

    setTimeout(() => {
      if (item.ruta.includes('?')) {
        let ruta = item.ruta.split('?');
        let path = `/${ruta[0]}`;
        let params = this.stringToObject(ruta[1]);

        currentPath === path
          ? this.changeRoute(path, params, true)
          : this.changeRoute(path, params);
      } else {
        this.changeRoute(item.ruta, {});
      }
    }, 450);
  }

  eliminar(item: Novedad) {
    let index = this.novedades.findIndex((ob) => ob === item);

    if (index !== -1) {
      this.load(true, false);

      this.novedadService.delete(item.idNovedad).subscribe({
        next: (data: any) => {
          console.log(data);

          let { error, info } = data.response;
          if (error === 0) {
            this.novedades.splice(index, 1);
            this.numItem.emit({ value: -1, eliminarTodo: false });
          } else {
            this.alertError(TitleErrorForm, info);
          }
          this.load(false, false);
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
  }

  borrarTodo() {
    this.load(true, false);
    this.novedadService.deleteByUsuario().subscribe({
      next: (data: any) => {
        console.log(data);

        let { error, info } = data.response;
        if (error === 0) {
          this.novedades = [];
          this.numItem.emit({ value: 0, eliminarTodo: true });
        } else {
          this.alertError(TitleErrorForm, info);
        }
        this.load(false, false);
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

  stringToObject(input: string): { [key: string]: string } {
    const result: { [key: string]: string } = {};
    const pairs = input.split('&');

    pairs.forEach((pair) => {
      const [key, value] = pair.split('=').map(decodeURIComponent);
      result[key] = value;
    });

    return result;
  }
}
