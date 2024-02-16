import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

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
    ToastModule,
  ],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
