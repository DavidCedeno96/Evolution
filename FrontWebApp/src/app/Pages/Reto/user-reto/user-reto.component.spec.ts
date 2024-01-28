import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UserRetoComponent } from './user-reto.component';

describe('UserRetoComponent', () => {
  let component: UserRetoComponent;
  let fixture: ComponentFixture<UserRetoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [UserRetoComponent]
    });
    fixture = TestBed.createComponent(UserRetoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
