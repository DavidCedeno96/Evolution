import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UpsertPreguntaComponent } from './upsert-pregunta.component';

describe('UpsertPreguntaComponent', () => {
  let component: UpsertPreguntaComponent;
  let fixture: ComponentFixture<UpsertPreguntaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [UpsertPreguntaComponent]
    });
    fixture = TestBed.createComponent(UpsertPreguntaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
