import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './Pages/login/login.component';
import { HomeAdminComponent } from './Pages/home-admin/home-admin.component';

const routes: Routes = [
  { path: 'login', component: LoginComponent },
  { path: 'homeAdmin', component: HomeAdminComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
