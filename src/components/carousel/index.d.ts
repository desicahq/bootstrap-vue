//
// Carousel
//
import Vue from 'vue'
import { desikit_plugin, BvComponent } from '../../'

// Plugin
export declare const CarouselPlugin: desikit_plugin

// Component: b-carousel
export declare class BCarousel extends BvComponent {
  setSlide: (slide: number) => void
  prev: () => void
  next: () => void
  start: () => void
  pause: () => void
}

// Component: b-carousel-slide
export declare class BCarouselSlide extends BvComponent {}
