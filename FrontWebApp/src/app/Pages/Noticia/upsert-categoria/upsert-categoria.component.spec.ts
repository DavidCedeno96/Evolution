import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UpsertCategoriaComponent } from './upsert-categoria.component';

describe('UpsertCategoriaComponent', () => {
  let component: UpsertCategoriaComponent;
  let fixture: ComponentFixture<UpsertCategoriaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [UpsertCategoriaComponent]
    });
    fixture = TestBed.createComponent(UpsertCategoriaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
