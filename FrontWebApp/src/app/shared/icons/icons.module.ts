import { NgModule } from '@angular/core';
import { DomSanitizer } from '@angular/platform-browser';
import { MatIconRegistry } from '@angular/material/icon';

@NgModule({})
export class IconModule {
  constructor(
    private _domZanitizer: DomSanitizer,
    private _matIconRegistry: MatIconRegistry
  ) {
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
  }
}
