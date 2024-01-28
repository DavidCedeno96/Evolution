import { ComponentFixture, TestBed } from '@angular/core/testing';

import { JuegoRetoComponent } from './juego-reto.component';

describe('JuegoRetoComponent', () => {
  let component: JuegoRetoComponent;
  let fixture: ComponentFixture<JuegoRetoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [JuegoRetoComponent]
    });
    fixture = TestBed.createComponent(JuegoRetoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
