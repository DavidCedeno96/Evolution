import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UpsertNivelComponent } from './upsert-nivel.component';

describe('UpsertNivelComponent', () => {
  let component: UpsertNivelComponent;
  let fixture: ComponentFixture<UpsertNivelComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [UpsertNivelComponent]
    });
    fixture = TestBed.createComponent(UpsertNivelComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
