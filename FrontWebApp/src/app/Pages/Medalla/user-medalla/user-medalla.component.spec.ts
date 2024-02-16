import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UserMedallaComponent } from './user-medalla.component';

describe('UserMedallaComponent', () => {
  let component: UserMedallaComponent;
  let fixture: ComponentFixture<UserMedallaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [UserMedallaComponent]
    });
    fixture = TestBed.createComponent(UserMedallaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
