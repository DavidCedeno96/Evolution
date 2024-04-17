import { TestBed } from '@angular/core/testing';

import { CategoriaRecompensaService } from './categoria-recompensa.service';

describe('CategoriaRecompensaService', () => {
  let service: CategoriaRecompensaService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(CategoriaRecompensaService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
