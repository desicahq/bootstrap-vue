//
// Nav
//
import Vue from 'vue'
import { desikit_plugin, BvComponent } from '../../'

// Plugin
export declare const NavPlugin: desikit_plugin

// Component: b-nav
export declare class BNav extends BvComponent {}

// Component: b-nav-form
export declare class BNavForm extends BvComponent {}

// Component: b-nav-item
export declare class BNavItem extends BvComponent {}

// Component: b-nav-item-dropdown
export declare class BNavItemDropdown extends BvComponent {
  // Public methods
  show: () => void
  hide: (refocus?: boolean) => void
}

// Component: b-nav-text
export declare class BNavText extends BvComponent {}
