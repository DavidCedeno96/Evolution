import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class ConfigAppService {
  private config: any = (window as any).config;

  constructor() {}

  get restUrl(): string {
    return this.config.restUrl;
  }

  get playMove(): string {
    return this.config.playMove;
  }
}
