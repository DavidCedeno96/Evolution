import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UpsertPreguntaSegEvaComponent } from './upsert-pregunta-seg-eva.component';

describe('UpsertPreguntaSegEvaComponent', () => {
  let component: UpsertPreguntaSegEvaComponent;
  let fixture: ComponentFixture<UpsertPreguntaSegEvaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [UpsertPreguntaSegEvaComponent]
    });
    fixture = TestBed.createComponent(UpsertPreguntaSegEvaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
