import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MassActionsAsigUserRetoComponent } from './mass-actions-asig-user-reto.component';

describe('MassActionsAsigUserRetoComponent', () => {
  let component: MassActionsAsigUserRetoComponent;
  let fixture: ComponentFixture<MassActionsAsigUserRetoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [MassActionsAsigUserRetoComponent]
    });
    fixture = TestBed.createComponent(MassActionsAsigUserRetoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
