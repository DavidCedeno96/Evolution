import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UpsertMedallaComponent } from './upsert-medalla.component';

describe('UpsertMedallaComponent', () => {
  let component: UpsertMedallaComponent;
  let fixture: ComponentFixture<UpsertMedallaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [UpsertMedallaComponent]
    });
    fixture = TestBed.createComponent(UpsertMedallaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
