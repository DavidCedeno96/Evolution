import { Component, OnInit } from '@angular/core';
import { Router, NavigationEnd } from '@angular/router';
import { filter } from 'rxjs/operators';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
})
export class AppComponent implements OnInit {
  showNavbarFooter: boolean = false;
  showSpace: boolean = false;
  url: string = '';

  constructor(private router: Router) {
    this.router.events
      .pipe(filter((event) => event instanceof NavigationEnd))
      .subscribe({
        next: (data: any) => {
          this.url = data.url;
          if (this.url.includes('/login') || this.url.includes('/register')) {
            this.showNavbarFooter = false;
          } else {
            this.showNavbarFooter = true;
          }
          if (this.url.includes('/login')) {
            this.showSpace = false;
          } else {
            this.showSpace = true;
          }
        },
      });
  }

  ngOnInit(): void {}

  itemActive(activeUrl: string): string {
    if (activeUrl === this.url) {
      return 'active';
    }
    return '';
  }
}
