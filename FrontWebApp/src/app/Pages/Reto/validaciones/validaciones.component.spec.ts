import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ValidacionesComponent } from './validaciones.component';

describe('ValidacionesComponent', () => {
  let component: ValidacionesComponent;
  let fixture: ComponentFixture<ValidacionesComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ValidacionesComponent]
    });
    fixture = TestBed.createComponent(ValidacionesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
