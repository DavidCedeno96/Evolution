import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UpsertCategoriaRecompensaComponent } from './upsert-categoria-recompensa.component';

describe('UpsertCategoriaRecompensaComponent', () => {
  let component: UpsertCategoriaRecompensaComponent;
  let fixture: ComponentFixture<UpsertCategoriaRecompensaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [UpsertCategoriaRecompensaComponent]
    });
    fixture = TestBed.createComponent(UpsertCategoriaRecompensaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
