import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
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

const routes: Routes = [
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'homeAdmin', component: HomeAdminComponent },
  { path: 'homeUser', component: HomeUserComponent },
  { path: 'view-user', component: ViewUserComponent },
  { path: 'upsert-user', component: UpsertUserComponent },
  { path: 'view-noticia', component: ViewNoticiaComponent },
  { path: 'view-categoria-noticia', component: ViewCategoriaComponent },
  { path: 'upsert-categoria-noticia', component: UpsertCategoriaComponent },
  { path: 'upsert-noticia', component: UpsertNoticiaComponent },
  { path: 'view-recompensa', component: ViewRecompensaComponent },
  { path: 'upsert-recompensa', component: UpsertRecompensaComponent },
  { path: 'view-nivel', component: ViewNivelComponent },
  { path: 'upsert-nivel', component: UpsertNivelComponent },
  { path: 'view-medalla', component: ViewMedallaComponent },
  { path: 'upsert-medalla', component: UpsertMedallaComponent },
  { path: 'view-reto', component: ViewRetoComponent },
  { path: 'upsert-reto', component: UpsertRetoComponent },
  { path: 'user-reto', component: UserRetoComponent },
  { path: 'entrada-reto', component: EntradaRetoComponent },
  { path: 'juego-reto', component: JuegoRetoComponent },
  { path: 'view-pregunta', component: ViewPreguntaComponent },
  { path: 'upsert-pregunta', component: UpsertPreguntaComponent },
  { path: 'config', component: ConfiguracionComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
