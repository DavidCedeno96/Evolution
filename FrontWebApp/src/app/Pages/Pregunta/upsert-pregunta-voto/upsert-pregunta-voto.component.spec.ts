import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UpsertPreguntaVotoComponent } from './upsert-pregunta-voto.component';

describe('UpsertPreguntaVotoComponent', () => {
  let component: UpsertPreguntaVotoComponent;
  let fixture: ComponentFixture<UpsertPreguntaVotoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [UpsertPreguntaVotoComponent]
    });
    fixture = TestBed.createComponent(UpsertPreguntaVotoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
