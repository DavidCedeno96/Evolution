import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FinRetoComponent } from './fin-reto.component';

describe('FinRetoComponent', () => {
  let component: FinRetoComponent;
  let fixture: ComponentFixture<FinRetoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [FinRetoComponent]
    });
    fixture = TestBed.createComponent(FinRetoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
