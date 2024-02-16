import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UserRecompensaComponent } from './user-recompensa.component';

describe('UserRecompensaComponent', () => {
  let component: UserRecompensaComponent;
  let fixture: ComponentFixture<UserRecompensaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [UserRecompensaComponent]
    });
    fixture = TestBed.createComponent(UserRecompensaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
