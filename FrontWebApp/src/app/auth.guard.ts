import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { UsuarioService } from './services/usuario.service';

export const authGuard: CanActivateFn = (route, state) => {
  return true;
};

export const authGuardAdmin: CanActivateFn = () => {
  const usuarioServicio = inject(UsuarioService);
  const router = inject(Router);

  if (usuarioServicio.loggedIn()) {
    if (
      usuarioServicio.getRol() == 'adm' ||
      usuarioServicio.getRol() == 'sadm'
    ) {
      return true;
    } else {
      router.navigate(['/login']);
      return false;
    }
  } else {
    router.navigate(['/login']);
    return false;
  }
};

export const authGuardPlayer: CanActivateFn = () => {
  const usuarioServicio = inject(UsuarioService);
  const router = inject(Router);

  if (usuarioServicio.loggedIn()) {
    if (
      usuarioServicio.getRol() == 'jug' ||
      usuarioServicio.getRol() == 'adm' ||
      usuarioServicio.getRol() == 'sadm'
    ) {
      return true;
    } else {
      router.navigate(['/login']);
      return false;
    }
  } else {
    router.navigate(['/login']);
    return false;
  }
};
