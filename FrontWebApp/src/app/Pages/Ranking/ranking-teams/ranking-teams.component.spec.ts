import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RankingTeamsComponent } from './ranking-teams.component';

describe('RankingTeamsComponent', () => {
  let component: RankingTeamsComponent;
  let fixture: ComponentFixture<RankingTeamsComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [RankingTeamsComponent]
    });
    fixture = TestBed.createComponent(RankingTeamsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
