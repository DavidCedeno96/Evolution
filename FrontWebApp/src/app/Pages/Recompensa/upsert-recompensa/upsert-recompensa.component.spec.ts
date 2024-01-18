import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UpsertRecompensaComponent } from './upsert-recompensa.component';

describe('UpsertRecompensaComponent', () => {
  let component: UpsertRecompensaComponent;
  let fixture: ComponentFixture<UpsertRecompensaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [UpsertRecompensaComponent]
    });
    fixture = TestBed.createComponent(UpsertRecompensaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
