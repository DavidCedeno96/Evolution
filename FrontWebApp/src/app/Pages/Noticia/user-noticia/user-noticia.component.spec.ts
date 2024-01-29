import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UserNoticiaComponent } from './user-noticia.component';

describe('UserNoticiaComponent', () => {
  let component: UserNoticiaComponent;
  let fixture: ComponentFixture<UserNoticiaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [UserNoticiaComponent]
    });
    fixture = TestBed.createComponent(UserNoticiaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
