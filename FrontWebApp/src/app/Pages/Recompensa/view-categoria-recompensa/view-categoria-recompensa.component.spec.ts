import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ViewCategoriaRecompensaComponent } from './view-categoria-recompensa.component';

describe('ViewCategoriaRecompensaComponent', () => {
  let component: ViewCategoriaRecompensaComponent;
  let fixture: ComponentFixture<ViewCategoriaRecompensaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ViewCategoriaRecompensaComponent]
    });
    fixture = TestBed.createComponent(ViewCategoriaRecompensaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
