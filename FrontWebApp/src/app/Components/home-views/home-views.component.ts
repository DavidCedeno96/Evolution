import { Component, ElementRef, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-home-views',
  templateUrl: './home-views.component.html',
  styleUrls: ['./home-views.component.css'],
})
export class HomeViewsComponent implements OnInit {
  @Input() tipoVista: string = '';

  customOuterStrokeColor: string = '';

  constructor(private el: ElementRef) {}

  ngOnInit(): void {
    this.getPrimaryColor();
  }

  getPrimaryColor() {
    this.customOuterStrokeColor = window
      .getComputedStyle(this.el.nativeElement)
      .getPropertyValue('--Primario');
  }
}
