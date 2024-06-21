import { Injectable } from '@angular/core';
import { API_URL_BUNNY_CDN } from '../Utils/Constants';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable, forkJoin } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class BunnyCdnService {
  private apiURL: string = API_URL_BUNNY_CDN + '/play-move';
  private accessKey: string = '28576cc6-9e02-4d88-8e1f51b4531f-5ace-4504';

  constructor(private http: HttpClient) {}

  subirArchivos(files: File[], vdeosNames: string[]): Observable<any[]> {
    const uploadRequests = files.map((file, i) => {
      let uniqueFileName: string = vdeosNames[i];

      const headers = new HttpHeaders({
        AccessKey: this.accessKey,
        'Content-Type': file.type,
      });

      return this.http.put(`${this.apiURL}/${uniqueFileName}`, file, {
        headers,
      });
    });

    return forkJoin(uploadRequests);
  }
}
