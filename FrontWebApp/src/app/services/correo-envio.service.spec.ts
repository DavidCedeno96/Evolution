import { TestBed } from '@angular/core/testing';

import { CorreoEnvioService } from './correo-envio.service';

describe('CorreoEnvioService', () => {
  let service: CorreoEnvioService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(CorreoEnvioService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
