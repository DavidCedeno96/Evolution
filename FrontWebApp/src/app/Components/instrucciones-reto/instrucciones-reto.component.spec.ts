import { ComponentFixture, TestBed } from '@angular/core/testing';

import { InstruccionesRetoComponent } from './instrucciones-reto.component';

describe('InstruccionesRetoComponent', () => {
  let component: InstruccionesRetoComponent;
  let fixture: ComponentFixture<InstruccionesRetoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [InstruccionesRetoComponent]
    });
    fixture = TestBed.createComponent(InstruccionesRetoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
