import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UpsertNotificacionComponent } from './upsert-notificacion.component';

describe('UpsertNotificacionComponent', () => {
  let component: UpsertNotificacionComponent;
  let fixture: ComponentFixture<UpsertNotificacionComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [UpsertNotificacionComponent]
    });
    fixture = TestBed.createComponent(UpsertNotificacionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
