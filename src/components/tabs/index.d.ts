//
// Tabs
//
import Vue from 'vue'
import { desikit_plugin, BvComponent } from '../../'

// Plugin
export declare const TabsPlugin: desikit_plugin

// Component: b-tabs
export declare class BTabs extends BvComponent {}

// Component: b-tab
export declare class BTab extends BvComponent {
  activate: () => boolean
  deactivate: () => boolean
}
