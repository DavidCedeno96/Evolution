import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HomeViewsComponent } from './home-views.component';

describe('HomeViewsComponent', () => {
  let component: HomeViewsComponent;
  let fixture: ComponentFixture<HomeViewsComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [HomeViewsComponent]
    });
    fixture = TestBed.createComponent(HomeViewsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
