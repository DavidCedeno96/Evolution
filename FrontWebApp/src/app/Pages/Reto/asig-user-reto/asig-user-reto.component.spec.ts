import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AsigUserRetoComponent } from './asig-user-reto.component';

describe('AsigUserRetoComponent', () => {
  let component: AsigUserRetoComponent;
  let fixture: ComponentFixture<AsigUserRetoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [AsigUserRetoComponent]
    });
    fixture = TestBed.createComponent(AsigUserRetoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
