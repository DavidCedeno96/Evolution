import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ValidacionesUsersComponent } from './validaciones-users.component';

describe('ValidacionesUsersComponent', () => {
  let component: ValidacionesUsersComponent;
  let fixture: ComponentFixture<ValidacionesUsersComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ValidacionesUsersComponent]
    });
    fixture = TestBed.createComponent(ValidacionesUsersComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
