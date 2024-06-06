import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { authGuardAdmin, authGuardPlayer } from './auth.guard';

/* PAGINAS */
import { LoginComponent } from './Pages/login/login.component';
import { RegisterComponent } from './Pages/register/register.component';
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
import { UserRetoComponent } from './Pages/Reto/user-reto/user-reto.component';
import { EntradaRetoComponent } from './Pages/Reto/entrada-reto/entrada-reto.component';
import { JuegoRetoComponent } from './Pages/Reto/juego-reto/juego-reto.component';
import { UserNoticiaComponent } from './Pages/Noticia/user-noticia/user-noticia.component';
import { UserMedallaComponent } from './Pages/Medalla/user-medalla/user-medalla.component';
import { UserNivelComponent } from './Pages/Nivel/user-nivel/user-nivel.component';
import { UserRecompensaComponent } from './Pages/Recompensa/user-recompensa/user-recompensa.component';
import { HomeComponent } from './Pages/home/home.component';
import { AsigUserRetoComponent } from './Pages/Reto/asig-user-reto/asig-user-reto.component';
import { RedSocialComponent } from './Pages/RedSocial/red-social/red-social.component';
import { NotificacionComponent } from './Pages/Config/notificacion/notificacion.component';
import { InicioComponent } from './Pages/Config/inicio/inicio.component';
import { UpsertNotificacionComponent } from './Pages/Config/upsert-notificacion/upsert-notificacion.component';
import { ProfileUserComponent } from './Pages/Usuario/profile-user/profile-user.component';
import { MassActionsUserComponent } from './Pages/Usuario/mass-actions-user/mass-actions-user.component';
import { MassActionsAsigUserRetoComponent } from './Pages/Reto/mass-actions-asig-user-reto/mass-actions-asig-user-reto.component';
import { MarcaComponent } from './Pages/Config/marca/marca.component';
import { CamposComponent } from './Pages/Config/campos/campos.component';
import { RegistroComponent } from './Pages/Config/registro/registro.component';
import { RedUserComponent } from './Pages/RedSocial/red-user/red-user.component';
import { ProfileUserEditComponent } from './Pages/Usuario/profile-user-edit/profile-user-edit.component';
import { ViewEquipoComponent } from './Pages/Equipo/view-equipo/view-equipo.component';
import { UpsertEquipoComponent } from './Pages/Equipo/upsert-equipo/upsert-equipo.component';
import { AsigUserEquipoComponent } from './Pages/Equipo/asig-user-equipo/asig-user-equipo.component';
import { MassActionsAsigUserEquipoComponent } from './Pages/Equipo/mass-actions-asig-user-equipo/mass-actions-asig-user-equipo.component';
import { AsigEquipoRetoComponent } from './Pages/Reto/asig-equipo-reto/asig-equipo-reto.component';
import { FinRetoComponent } from './Pages/Reto/fin-reto/fin-reto.component';
import { ViewCategoriaRecompensaComponent } from './Pages/Recompensa/view-categoria-recompensa/view-categoria-recompensa.component';
import { UpsertCategoriaRecompensaComponent } from './Pages/Recompensa/upsert-categoria-recompensa/upsert-categoria-recompensa.component';
import { RedSocialPerfilComponent } from './Pages/RedSocial/red-social-perfil/red-social-perfil.component';
import { RankingUsersComponent } from './Pages/Ranking/ranking-users/ranking-users.component';
import { RankingTeamsComponent } from './Pages/Ranking/ranking-teams/ranking-teams.component';
import { UpsertPreguntaVotoComponent } from './Pages/Pregunta/upsert-pregunta-voto/upsert-pregunta-voto.component';
import { UpsertPreguntaSatisfaccionComponent } from './Pages/Pregunta/upsert-pregunta-satisfaccion/upsert-pregunta-satisfaccion.component';
import { ResultsComponent } from './Pages/Pregunta/results/results.component';
import { UpsertPreguntaSegEvaComponent } from './Pages/Pregunta/upsert-pregunta-seg-eva/upsert-pregunta-seg-eva.component';
import { ValidacionesComponent } from './Pages/Reto/validaciones/validaciones.component';
import { ValidacionesUsersComponent } from './Pages/Reto/validaciones-users/validaciones-users.component';
import { ComportamientoComponent } from './Components/comportamiento/comportamiento.component';

const routes: Routes = [
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },
  {
    path: 'home',
    component: HomeComponent,
    canActivate: [authGuardPlayer],
  },
  {
    path: 'profile-user',
    component: ProfileUserComponent,
    canActivate: [authGuardPlayer],
  },
  {
    path: 'profile-user/edit',
    component: ProfileUserEditComponent,
    canActivate: [authGuardPlayer],
  },
  {
    path: 'view-equipo',
    component: ViewEquipoComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'upsert-equipo',
    component: UpsertEquipoComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'asig-user-equipo',
    component: AsigUserEquipoComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'mass-actions-asig-user-equipo',
    component: MassActionsAsigUserEquipoComponent,
    canActivate: [authGuardAdmin],
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
    path: 'mass-actions-user',
    component: MassActionsUserComponent,
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
    path: 'view-categoria-recompensa',
    component: ViewCategoriaRecompensaComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'upsert-categoria-recompensa',
    component: UpsertCategoriaRecompensaComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'user-recompensa',
    component: UserRecompensaComponent,
    canActivate: [authGuardPlayer],
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
    path: 'user-nivel',
    component: UserNivelComponent,
    canActivate: [authGuardPlayer],
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
    path: 'user-medalla',
    component: UserMedallaComponent,
    canActivate: [authGuardPlayer],
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
    path: 'fin-reto',
    component: FinRetoComponent,
    canActivate: [authGuardPlayer],
  },
  {
    path: 'validaciones',
    component: ValidacionesComponent,
    canActivate: [authGuardPlayer],
  },
  {
    path: 'validaciones/users',
    component: ValidacionesUsersComponent,
    canActivate: [authGuardPlayer],
  },
  {
    path: 'asig-user-reto',
    component: AsigUserRetoComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'asig-equipo-reto',
    component: AsigEquipoRetoComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'mass-actions-asig-user-reto',
    component: MassActionsAsigUserRetoComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'validar-comportamiento',
    component: ComportamientoComponent,
    canActivate: [authGuardPlayer],
  },
  {
    path: 'view-pregunta',
    component: ViewPreguntaComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'upsert-pregunta/trivia',
    component: UpsertPreguntaComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'upsert-pregunta/encuesta/voto',
    component: UpsertPreguntaVotoComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'upsert-pregunta/encuesta/satisfaccion',
    component: UpsertPreguntaSatisfaccionComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'upsert-pregunta/seguimiento-evaluacion',
    component: UpsertPreguntaSegEvaComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'results',
    component: ResultsComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'red-social',
    component: RedSocialComponent,
    canActivate: [authGuardPlayer],
  },
  {
    path: 'red-social-perfil',
    component: RedSocialPerfilComponent,
    canActivate: [authGuardPlayer],
  },
  {
    path: 'red-user',
    component: RedUserComponent,
    canActivate: [authGuardPlayer],
  },
  {
    path: 'ranking-users',
    component: RankingUsersComponent,
    canActivate: [authGuardPlayer],
  },
  {
    path: 'ranking-teams',
    component: RankingTeamsComponent,
    canActivate: [authGuardPlayer],
  },
  {
    path: 'config/inicio',
    component: InicioComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'config/notification',
    component: NotificacionComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'config/upsert-notificacion',
    component: UpsertNotificacionComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'config/marca',
    component: MarcaComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'config/campos',
    component: CamposComponent,
    canActivate: [authGuardAdmin],
  },
  {
    path: 'config/registro',
    component: RegistroComponent,
    canActivate: [authGuardAdmin],
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
