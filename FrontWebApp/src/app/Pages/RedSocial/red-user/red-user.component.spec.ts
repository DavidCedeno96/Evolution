import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RedUserComponent } from './red-user.component';

describe('RedUserComponent', () => {
  let component: RedUserComponent;
  let fixture: ComponentFixture<RedUserComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [RedUserComponent]
    });
    fixture = TestBed.createComponent(RedUserComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
