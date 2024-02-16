import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UserNivelComponent } from './user-nivel.component';

describe('UserNivelComponent', () => {
  let component: UserNivelComponent;
  let fixture: ComponentFixture<UserNivelComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [UserNivelComponent]
    });
    fixture = TestBed.createComponent(UserNivelComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
