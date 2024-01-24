import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UpsertRetoComponent } from './upsert-reto.component';

describe('UpsertRetoComponent', () => {
  let component: UpsertRetoComponent;
  let fixture: ComponentFixture<UpsertRetoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [UpsertRetoComponent]
    });
    fixture = TestBed.createComponent(UpsertRetoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
