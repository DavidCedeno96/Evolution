import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ProfileUserEditComponent } from './profile-user-edit.component';

describe('ProfileUserEditComponent', () => {
  let component: ProfileUserEditComponent;
  let fixture: ComponentFixture<ProfileUserEditComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ProfileUserEditComponent]
    });
    fixture = TestBed.createComponent(ProfileUserEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
