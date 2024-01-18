import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ViewRecompensaComponent } from './view-recompensa.component';

describe('ViewRecompensaComponent', () => {
  let component: ViewRecompensaComponent;
  let fixture: ComponentFixture<ViewRecompensaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ViewRecompensaComponent]
    });
    fixture = TestBed.createComponent(ViewRecompensaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
