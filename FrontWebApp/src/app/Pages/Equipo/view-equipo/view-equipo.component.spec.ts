import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ViewEquipoComponent } from './view-equipo.component';

describe('ViewEquipoComponent', () => {
  let component: ViewEquipoComponent;
  let fixture: ComponentFixture<ViewEquipoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ViewEquipoComponent]
    });
    fixture = TestBed.createComponent(ViewEquipoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
