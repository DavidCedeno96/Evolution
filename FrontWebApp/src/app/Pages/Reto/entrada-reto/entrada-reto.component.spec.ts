import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EntradaRetoComponent } from './entrada-reto.component';

describe('EntradaRetoComponent', () => {
  let component: EntradaRetoComponent;
  let fixture: ComponentFixture<EntradaRetoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [EntradaRetoComponent]
    });
    fixture = TestBed.createComponent(EntradaRetoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
