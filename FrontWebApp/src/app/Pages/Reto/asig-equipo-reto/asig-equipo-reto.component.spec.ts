import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AsigEquipoRetoComponent } from './asig-equipo-reto.component';

describe('AsigEquipoRetoComponent', () => {
  let component: AsigEquipoRetoComponent;
  let fixture: ComponentFixture<AsigEquipoRetoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [AsigEquipoRetoComponent]
    });
    fixture = TestBed.createComponent(AsigEquipoRetoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
