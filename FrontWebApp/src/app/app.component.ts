import { Component } from '@angular/core';
import { Router, NavigationEnd } from '@angular/router';
import { filter } from 'rxjs/operators';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
})
export class AppComponent {
  title = 'EvolutionApp';

  showNavbarFooter: boolean = false;

  constructor(private router: Router) {
    this.router.events
      .pipe(filter((event) => event instanceof NavigationEnd))
      .subscribe({
        next: (data: any) => {
          console.log(data.url);
          if (data.url.includes('/login')) {
            this.showNavbarFooter = false;
          } else {
            this.showNavbarFooter = true;
          }
        },
      });
  }
}
