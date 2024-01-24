import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ViewNivelComponent } from './view-nivel.component';

describe('ViewNivelComponent', () => {
  let component: ViewNivelComponent;
  let fixture: ComponentFixture<ViewNivelComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ViewNivelComponent]
    });
    fixture = TestBed.createComponent(ViewNivelComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
