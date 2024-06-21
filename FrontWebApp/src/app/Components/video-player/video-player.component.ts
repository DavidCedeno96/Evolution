import { Component, Input, OnInit } from '@angular/core';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';
import { ExtractString } from 'src/app/Utils/Constants';

@Component({
  selector: 'app-video-player',
  templateUrl: './video-player.component.html',
  styleUrls: ['./video-player.component.css'],
})
export class VideoPlayerComponent implements OnInit {
  extractString = ExtractString();

  @Input() videoUrl: string = '';

  url: string = '';
  video_id: string = '';

  constructor(private sanitizer: DomSanitizer) {}

  ngOnInit(): void {
    /* if (this.videoUrl.includes('youtube')) {      

      this.video_id = this.extractString(this.videoUrl, /v=([^&]+)/);
      this.url = `https://www.youtube.com/embed/${this.video_id}`;
    } else if (this.videoUrl.includes('vimeo')) {      

      this.video_id = this.extractString(this.videoUrl, /vimeo\.com\/(\d+)/);
      this.url = `https://player.vimeo.com/video/${this.video_id}`;
    } else if (this.videoUrl.includes('dailymotion')) {      

      this.video_id = this.extractString(
        this.videoUrl,
        /dailymotion\.com\/video\/([^_]+)/
      );
      this.url = `https://www.dailymotion.com/embed/video/${this.video_id}`;
    } */

    this.url = `https://play-move.b-cdn.net/${this.videoUrl}`;
  }

  get safeVideoUrl(): SafeResourceUrl {
    return this.sanitizer.bypassSecurityTrustResourceUrl(this.url!);
  }
}
