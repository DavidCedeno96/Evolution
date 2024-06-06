import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ComportamientoComponent } from './comportamiento.component';

describe('ComportamientoComponent', () => {
  let component: ComportamientoComponent;
  let fixture: ComponentFixture<ComportamientoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ComportamientoComponent]
    });
    fixture = TestBed.createComponent(ComportamientoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
