import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ViewMedallaComponent } from './view-medalla.component';

describe('ViewMedallaComponent', () => {
  let component: ViewMedallaComponent;
  let fixture: ComponentFixture<ViewMedallaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ViewMedallaComponent]
    });
    fixture = TestBed.createComponent(ViewMedallaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
