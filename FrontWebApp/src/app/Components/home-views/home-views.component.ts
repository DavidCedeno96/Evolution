import { Component, Input } from '@angular/core';
import { Usuario } from 'src/app/Models/Usuario';

@Component({
  selector: 'app-home-views',
  templateUrl: './home-views.component.html',
  styleUrls: ['./home-views.component.css'],
})
export class HomeViewsComponent {
  @Input() tipoVista: string = '';
}
