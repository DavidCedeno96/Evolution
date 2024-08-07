import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

import { CommonModule } from '@angular/common';

//Shared
import { SafeResourceUrlPipe } from './shared/securityTrustHtml/safe-url.pipe';
import { SharedModule } from './shared/shared.module';

//Material
import { MatIconModule } from '@angular/material/icon';

// tooltip
import { MatTooltipModule } from '@angular/material/tooltip';

// ng-circle-progress
import { NgCircleProgressModule } from 'ng-circle-progress';

// Este es para la apiRest
import { HttpClientModule, HttpClient } from '@angular/common/http';

// Es para el Traductor
import { TranslateModule, TranslateLoader } from '@ngx-translate/core';
import { TranslateHttpLoader } from '@ngx-translate/http-loader';

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
import { CalendarModule } from 'primeng/calendar';
import { InputMaskModule } from 'primeng/inputmask';
import { TableModule } from 'primeng/table';
import { MenuModule } from 'primeng/menu';

/* PÁGINAS */
import { LoginComponent } from './Pages/login/login.component';
import { RegisterComponent } from './Pages/register/register.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
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
import { EncuestaComponent } from './Components/encuesta/encuesta.component';
import { UpsertPreguntaSatisfaccionComponent } from './Pages/Pregunta/upsert-pregunta-satisfaccion/upsert-pregunta-satisfaccion.component';
import { UpsertPreguntaVotoComponent } from './Pages/Pregunta/upsert-pregunta-voto/upsert-pregunta-voto.component';
import { ResultsComponent } from './Pages/Pregunta/results/results.component';
import { UpsertPreguntaSegEvaComponent } from './Pages/Pregunta/upsert-pregunta-seg-eva/upsert-pregunta-seg-eva.component';
import { GraficoComponent } from './Components/grafico/grafico.component';
import { SeguimientoEvaluacionComponent } from './Components/seguimiento-evaluacion/seguimiento-evaluacion.component';
import { RecoleccionComponent } from './Components/recoleccion/recoleccion.component';
import { ComportamientoComponent } from './Components/comportamiento/comportamiento.component';
import { ValidacionesComponent } from './Pages/Reto/validaciones/validaciones.component';
import { ValidacionesUsersComponent } from './Pages/Reto/validaciones-users/validaciones-users.component';
import { InstruccionesRetoComponent } from './Components/instrucciones-reto/instrucciones-reto.component';
import { VideoPlayerComponent } from './Components/video-player/video-player.component';
import { PageNotFoundComponent } from './Pages/page-not-found/page-not-found.component';
import { NovedadesComponent } from './Components/novedades/novedades.component';
import { CorreoMasivoComponent } from './Pages/Config/correo-masivo/correo-masivo.component';
import { RecoverPasswordComponent } from './Pages/recover-password/recover-password.component';

export function HttpLoaderFactory(http: HttpClient) {
  return new TranslateHttpLoader(http);
}

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
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
    RedSocialPerfilComponent,
    RankingUsersComponent,
    RankingTeamsComponent,
    EncuestaComponent,
    UpsertPreguntaSatisfaccionComponent,
    UpsertPreguntaVotoComponent,
    ResultsComponent,
    UpsertPreguntaSegEvaComponent,
    GraficoComponent,
    SeguimientoEvaluacionComponent,
    RecoleccionComponent,
    ComportamientoComponent,
    ValidacionesComponent,
    ValidacionesUsersComponent,
    InstruccionesRetoComponent,
    VideoPlayerComponent,
    SafeResourceUrlPipe,
    PageNotFoundComponent,
    NovedadesComponent,
    CorreoMasivoComponent,
    RecoverPasswordComponent,
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
    CalendarModule,
    InputMaskModule,
    TableModule,
    MenuModule,
    CommonModule,
    MatTooltipModule,
    TranslateModule.forRoot({
      loader: {
        provide: TranslateLoader,
        useFactory: HttpLoaderFactory,
        deps: [HttpClient],
      },
    }),
    NgCircleProgressModule.forRoot({
      responsive: true,
      showSubtitle: false,
      showBackground: false,
      showInnerStroke: true,
      animation: true,
      animationDuration: 400,
      radius: 15,
      outerStrokeWidth: 3,
      innerStrokeWidth: 3,
      outerStrokeColor: 'f58220',
      innerStrokeColor: '#F1F1F1',
      titleFontSize: '9',
      space: -3,
    }),
  ],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
