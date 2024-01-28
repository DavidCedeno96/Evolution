import { Component, OnInit } from '@angular/core';
import { ChangeRoute } from 'src/app/Utils/Constants';

@Component({
  selector: 'app-entrada-reto',
  templateUrl: './entrada-reto.component.html',
  styleUrls: ['./entrada-reto.component.css'],
})
export class EntradaRetoComponent implements OnInit {
  changeRoute = ChangeRoute();

  ngOnInit(): void {}
}
