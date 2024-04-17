import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MassActionsUserComponent } from './mass-actions-user.component';

describe('MassActionsUserComponent', () => {
  let component: MassActionsUserComponent;
  let fixture: ComponentFixture<MassActionsUserComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [MassActionsUserComponent]
    });
    fixture = TestBed.createComponent(MassActionsUserComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
