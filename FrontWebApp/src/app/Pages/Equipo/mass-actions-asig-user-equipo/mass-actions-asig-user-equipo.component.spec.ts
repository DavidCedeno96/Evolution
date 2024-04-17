import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MassActionsAsigUserEquipoComponent } from './mass-actions-asig-user-equipo.component';

describe('MassActionsAsigUserEquipoComponent', () => {
  let component: MassActionsAsigUserEquipoComponent;
  let fixture: ComponentFixture<MassActionsAsigUserEquipoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [MassActionsAsigUserEquipoComponent]
    });
    fixture = TestBed.createComponent(MassActionsAsigUserEquipoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
