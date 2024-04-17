import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UpsertEquipoComponent } from './upsert-equipo.component';

describe('UpsertEquipoComponent', () => {
  let component: UpsertEquipoComponent;
  let fixture: ComponentFixture<UpsertEquipoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [UpsertEquipoComponent]
    });
    fixture = TestBed.createComponent(UpsertEquipoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
