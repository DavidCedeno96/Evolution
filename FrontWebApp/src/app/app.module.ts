import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

import { CommonModule } from '@angular/common';

// tooltip
import { MatTooltipModule } from '@angular/material/tooltip';

// Este es para la apiRest
import { HttpClientModule } from '@angular/common/http';

/* FORMS */
import { ReactiveFormsModule, FormsModule } from '@angular/forms';

/* ARRASTRAR ITEMS */
import { DragDropModule } from '@angular/cdk/drag-drop';

/* PRIMENG */
import { DataViewModule } from 'primeng/dataview';
import { SplitButtonModule } from 'primeng/splitbutton';
import { InputTextModule } from 'primeng/inputtext';
import { PaginatorModule } from 'primeng/paginator';
import { ConfirmDialogModule } from 'primeng/confirmdialog';
import { DialogModule } from 'primeng/dialog';
import { ToastModule } from 'primeng/toast';

/* PÁGINAS */
import { LoginComponent } from './Pages/login/login.component';
import { HomeAdminComponent } from './Pages/home-admin/home-admin.component';
import { RegisterComponent } from './Pages/register/register.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { SharedModule } from './shared/shared.module';
import { MatIconModule } from '@angular/material/icon';
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
import { TriviaComponent } from './Components/trivia/trivia.component';
import { UserNoticiaComponent } from './Pages/Noticia/user-noticia/user-noticia.component';
import { UserMedallaComponent } from './Pages/Medalla/user-medalla/user-medalla.component';
import { UserNivelComponent } from './Pages/Nivel/user-nivel/user-nivel.component';
import { UserRecompensaComponent } from './Pages/Recompensa/user-recompensa/user-recompensa.component';
import { HomeComponent } from './Pages/home/home.component';
import { HomeViewsComponent } from './Components/home-views/home-views.component';
import { AsigUserRetoComponent } from './Pages/Reto/asig-user-reto/asig-user-reto.component';
import { RedSocialComponent } from './Pages/RedSocial/red-social/red-social.component';
import { RankingComponent } from './Pages/ranking/ranking.component';
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

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    HomeAdminComponent,
    RegisterComponent,
    ConfiguracionComponent,
    ViewUserComponent,
    UpsertUserComponent,
    ViewNoticiaComponent,
    UpsertNoticiaComponent,
    ViewCategoriaComponent,
    UpsertCategoriaComponent,
    ViewRecompensaComponent,
    UpsertRecompensaComponent,
    ViewNivelComponent,
    UpsertNivelComponent,
    ViewMedallaComponent,
    UpsertMedallaComponent,
    ViewRetoComponent,
    UpsertRetoComponent,
    ViewPreguntaComponent,
    UpsertPreguntaComponent,
    HomeUserComponent,
    UserRetoComponent,
    EntradaRetoComponent,
    JuegoRetoComponent,
    TriviaComponent,
    UserNoticiaComponent,
    UserMedallaComponent,
    UserNivelComponent,
    UserRecompensaComponent,
    HomeComponent,
    HomeViewsComponent,
    AsigUserRetoComponent,
    RedSocialComponent,
    RankingComponent,
    NotificacionComponent,
    InicioComponent,
    UpsertNotificacionComponent,
    ProfileUserComponent,
    MassActionsUserComponent,
    MassActionsAsigUserRetoComponent,
    MarcaComponent,
    CamposComponent,
    RegistroComponent,
    RedUserComponent,
    ProfileUserEditComponent,
    ViewEquipoComponent,
    UpsertEquipoComponent,
    AsigUserEquipoComponent,
    MassActionsAsigUserEquipoComponent,
    AsigEquipoRetoComponent,
    FinRetoComponent,
    ViewCategoriaRecompensaComponent,
    UpsertCategoriaRecompensaComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    ReactiveFormsModule,
    DragDropModule,
    FormsModule,
    BrowserAnimationsModule,
    SharedModule,
    MatIconModule,
    DataViewModule,
    SplitButtonModule,
    InputTextModule,
    PaginatorModule,
    ConfirmDialogModule,
    DialogModule,
    ToastModule,
    CommonModule,
    MatTooltipModule,
  ],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
