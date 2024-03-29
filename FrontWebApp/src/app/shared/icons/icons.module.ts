import { NgModule } from '@angular/core';
import { DomSanitizer } from '@angular/platform-browser';
import { MatIconRegistry } from '@angular/material/icon';

@NgModule({})
export class IconModule {
  constructor(
    private _domZanitizer: DomSanitizer,
    private _matIconRegistry: MatIconRegistry
  ) {
    /********** MENU **********/
    this._matIconRegistry.addSvgIcon(
      'casa',
      this._domZanitizer.bypassSecurityTrustResourceUrl('assets/icons/casa.svg')
    );
    this._matIconRegistry.addSvgIcon(
      'recompensa',
      this._domZanitizer.bypassSecurityTrustResourceUrl(
        'assets/icons/recompensa.svg'
      )
    );
    this._matIconRegistry.addSvgIcon(
      'grupo',
      this._domZanitizer.bypassSecurityTrustResourceUrl(
        'assets/icons/grupo.svg'
      )
    );
    this._matIconRegistry.addSvgIcon(
      'gamepad',
      this._domZanitizer.bypassSecurityTrustResourceUrl(
        'assets/icons/gamepad.svg'
      )
    );
    this._matIconRegistry.addSvgIcon(
      'periodico',
      this._domZanitizer.bypassSecurityTrustResourceUrl(
        'assets/icons/periodico.svg'
      )
    );
    this._matIconRegistry.addSvgIcon(
      'categoria',
      this._domZanitizer.bypassSecurityTrustResourceUrl(
        'assets/icons/categoria.svg'
      )
    );
    this._matIconRegistry.addSvgIcon(
      'podio',
      this._domZanitizer.bypassSecurityTrustResourceUrl(
        'assets/icons/podio.svg'
      )
    );
    this._matIconRegistry.addSvgIcon(
      'otorgar',
      this._domZanitizer.bypassSecurityTrustResourceUrl(
        'assets/icons/otorgar.svg'
      )
    );
    this._matIconRegistry.addSvgIcon(
      'reaccion',
      this._domZanitizer.bypassSecurityTrustResourceUrl(
        'assets/icons/reaccion.svg'
      )
    );
    this._matIconRegistry.addSvgIcon(
      'rueda-dentada',
      this._domZanitizer.bypassSecurityTrustResourceUrl(
        'assets/icons/rueda-dentada.svg'
      )
    );
    this._matIconRegistry.addSvgIcon(
      'cerrar-sesion',
      this._domZanitizer.bypassSecurityTrustResourceUrl(
        'assets/icons/cerrar-sesion.svg'
      )
    );

    /********** BOTONES **********/
    this._matIconRegistry.addSvgIcon(
      'agregar',
      this._domZanitizer.bypassSecurityTrustResourceUrl(
        'assets/icons/agregar.svg'
      )
    );
    this._matIconRegistry.addSvgIcon(
      'importar',
      this._domZanitizer.bypassSecurityTrustResourceUrl(
        'assets/icons/importar.svg'
      )
    );

    /********** OTROS **********/
    this._matIconRegistry.addSvgIcon(
      'corazon',
      this._domZanitizer.bypassSecurityTrustResourceUrl(
        'assets/icons/corazon.svg'
      )
    );
    this._matIconRegistry.addSvgIcon(
      'corazon-roto',
      this._domZanitizer.bypassSecurityTrustResourceUrl(
        'assets/icons/corazon-roto.svg'
      )
    );
    this._matIconRegistry.addSvgIcon(
      'reloj-arena',
      this._domZanitizer.bypassSecurityTrustResourceUrl(
        'assets/icons/reloj-de-arena.svg'
      )
    );
  }
}
