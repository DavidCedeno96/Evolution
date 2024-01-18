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

const routes: Routes = [
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'homeAdmin', component: HomeAdminComponent },
  { path: 'view-user', component: ViewUserComponent },
  { path: 'upsert-user', component: UpsertUserComponent },
  { path: 'view-noticia', component: ViewNoticiaComponent },
  { path: 'view-categoria-noticia', component: ViewCategoriaComponent },
  { path: 'upsert-categoria-noticia', component: UpsertCategoriaComponent },
  { path: 'upsert-noticia', component: UpsertNoticiaComponent },
  { path: 'view-recompensa', component: ViewRecompensaComponent },
  { path: 'upsert-recompensa', component: UpsertRecompensaComponent },
  { path: 'config', component: ConfiguracionComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
