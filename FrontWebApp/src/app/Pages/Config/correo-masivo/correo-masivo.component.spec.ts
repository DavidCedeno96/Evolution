import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CorreoMasivoComponent } from './correo-masivo.component';

describe('CorreoMasivoComponent', () => {
  let component: CorreoMasivoComponent;
  let fixture: ComponentFixture<CorreoMasivoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [CorreoMasivoComponent]
    });
    fixture = TestBed.createComponent(CorreoMasivoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
