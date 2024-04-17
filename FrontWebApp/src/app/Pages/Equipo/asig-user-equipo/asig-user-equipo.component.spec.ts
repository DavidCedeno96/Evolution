import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AsigUserEquipoComponent } from './asig-user-equipo.component';

describe('AsigUserEquipoComponent', () => {
  let component: AsigUserEquipoComponent;
  let fixture: ComponentFixture<AsigUserEquipoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [AsigUserEquipoComponent]
    });
    fixture = TestBed.createComponent(AsigUserEquipoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
