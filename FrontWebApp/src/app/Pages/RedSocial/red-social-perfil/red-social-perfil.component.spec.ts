import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RedSocialPerfilComponent } from './red-social-perfil.component';

describe('RedSocialPerfilComponent', () => {
  let component: RedSocialPerfilComponent;
  let fixture: ComponentFixture<RedSocialPerfilComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [RedSocialPerfilComponent]
    });
    fixture = TestBed.createComponent(RedSocialPerfilComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
