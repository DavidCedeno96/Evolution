import { TestBed } from '@angular/core/testing';

import { BunnyCdnService } from './bunny-cdn.service';

describe('BunnyCdnService', () => {
  let service: BunnyCdnService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(BunnyCdnService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
