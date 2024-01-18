import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UpsertNoticiaComponent } from './upsert-noticia.component';

describe('UpsertNoticiaComponent', () => {
  let component: UpsertNoticiaComponent;
  let fixture: ComponentFixture<UpsertNoticiaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [UpsertNoticiaComponent]
    });
    fixture = TestBed.createComponent(UpsertNoticiaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
