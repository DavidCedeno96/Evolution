import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ViewPreguntaComponent } from './view-pregunta.component';

describe('ViewPreguntaComponent', () => {
  let component: ViewPreguntaComponent;
  let fixture: ComponentFixture<ViewPreguntaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ViewPreguntaComponent]
    });
    fixture = TestBed.createComponent(ViewPreguntaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
