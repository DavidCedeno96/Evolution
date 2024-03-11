import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RedSocialComponent } from './red-social.component';

describe('RedSocialComponent', () => {
  let component: RedSocialComponent;
  let fixture: ComponentFixture<RedSocialComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [RedSocialComponent]
    });
    fixture = TestBed.createComponent(RedSocialComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
