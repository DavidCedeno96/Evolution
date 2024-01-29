import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { authGuardAdmin, authGuardPlayer } from './auth.guard';

/* PAGINAS */
import { LoginComponent } from './Pages/login/login.component';
import { RegisterComponent } from './Pages/register/register.component';
import { HomeAdminComponent } from './Pages/home-admin/home-admin.component';
import { ConfiguracionComponent } from './Pages/configuracion/configuracion.component';
import { ViewUserComponent } from './Pages/Usuario/view-user/view-user.component';
import { UpsertUserComponent } from './Pages/Usuario/upsert-user/upsert-user.component';
import { ViewNoticiaComponent } from './Pages/Noticia/view-noticia/view-noticia.component';
import { UpsertNoticiaComponent } from './Pages/Noticia/upsert-noticia/upsert-noticia.component';
import { ViewCategoriaComponent } from './Pages/Noticia/view-categoria/view-categoria.component';
import { UpsertCategoriaComponent } from './Pages/Noticia/upsert-categoria/upsert-categoria.component';
import { ViewRecompensaComponent } from './Pages/Recompensa/view-recompensa/view-recompensa.component';
import { UpsertRecompensaComponent } from './Pages/Recompensa/upsert-recompensa/upsert-recompensa.component';
import { ViewNivelComponent } from './Pages/Nivel/view-nivel/view-nivel.component';
import { UpsertNivelComponent } from './Pages/Nivel/upsert-nivel/upsert-nivel.component';
import { ViewMedallaComponent } from './Pages/Medalla/view-medalla/view-medalla.component';
import { UpsertMedallaComponent } from './Pages/Medalla/upsert-medalla/upsert-medalla.component';
import { ViewRetoComponent } from './Pages/Reto/view-reto/view-reto.component';
import { UpsertRetoComponent } from './Pages/Reto/upsert-reto/upsert-reto.component';
import { ViewPreguntaComponent } from './Pages/Pregunta/view-pregunta/view-pregunta.component';
import { UpsertPreguntaComponent } from './Pages/Pregunta/upsert-pregunta/upsert-pregunta.component';
import { HomeUserComponent } from './Pages/home-user/home-user.component';
import { UserRetoComponent } from './Pages/Reto/user-reto/user-reto.component';
import { EntradaRetoComponent } from './Pages/Reto/entrada-reto/entrada-reto.component';
import { JuegoRetoComponent } from './Pages/Reto/juego-reto/juego-reto.component';
import { UserNoticiaComponent } from './Pages/Noticia/user-noticia/user-noticia.component';

const routes: Routes = [
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },
  {
    path: 'homeAdmin',
    component: HomeAdminComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'homeUser',
    component: HomeUserComponent,
    canActivate: [authGuardPlayer],
  },
  {
    path: 'view-user',
    component: ViewUserComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'upsert-user',
    component: UpsertUserComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'view-noticia',
    component: ViewNoticiaComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'view-categoria-noticia',
    component: ViewCategoriaComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'upsert-categoria-noticia',
    component: UpsertCategoriaComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'upsert-noticia',
    component: UpsertNoticiaComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'user-noticia',
    component: UserNoticiaComponent,
    canActivate: [authGuardPlayer],
  },
  {
    path: 'view-recompensa',
    component: ViewRecompensaComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'upsert-recompensa',
    component: UpsertRecompensaComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'view-nivel',
    component: ViewNivelComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'upsert-nivel',
    component: UpsertNivelComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'view-medalla',
    component: ViewMedallaComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'upsert-medalla',
    component: UpsertMedallaComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'view-reto',
    component: ViewRetoComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'upsert-reto',
    component: UpsertRetoComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'user-reto',
    component: UserRetoComponent,
    canActivate: [authGuardPlayer],
  },
  {
    path: 'entrada-reto',
    component: EntradaRetoComponent,
    canActivate: [authGuardPlayer],
  },
  {
    path: 'juego-reto',
    component: JuegoRetoComponent,
    canActivate: [authGuardPlayer],
  },
  {
    path: 'view-pregunta',
    component: ViewPreguntaComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'upsert-pregunta',
    component: UpsertPreguntaComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'config',
    component: ConfiguracionComponent,
    canActivate: [authGuardAdmin],
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
