import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ViewRetoComponent } from './view-reto.component';

describe('ViewRetoComponent', () => {
  let component: ViewRetoComponent;
  let fixture: ComponentFixture<ViewRetoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ViewRetoComponent]
    });
    fixture = TestBed.createComponent(ViewRetoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
