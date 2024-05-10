import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UpsertPreguntaSatisfaccionComponent } from './upsert-pregunta-satisfaccion.component';

describe('UpsertPreguntaSatisfaccionComponent', () => {
  let component: UpsertPreguntaSatisfaccionComponent;
  let fixture: ComponentFixture<UpsertPreguntaSatisfaccionComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [UpsertPreguntaSatisfaccionComponent]
    });
    fixture = TestBed.createComponent(UpsertPreguntaSatisfaccionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
