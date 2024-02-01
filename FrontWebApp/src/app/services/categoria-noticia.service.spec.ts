import { TestBed } from '@angular/core/testing';

import { CategoriaNoticiaService } from './categoria-noticia.service';

describe('CategoriaNoticiaService', () => {
  let service: CategoriaNoticiaService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(CategoriaNoticiaService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
