// --- Modals ---
import Vue, { VNode } from 'vue'
import { desikit_plugin, BvComponent, BvEvent } from '../../'

// Modal plugin
export declare const ModalPlugin: desikit_plugin

// Component: <b-modal>
export declare class BModal extends BvComponent {
  // Public methods
  show: () => void
  hide: (trigger?: string) => void
}

// --- Types ---
export type BvMsgBoxData = boolean | null | BvModalEvent | any

// --- Interfaces ---
export interface BvModalEvent extends BvEvent {
  readonly trigger: string | null
  // Future
  // details: any | null
}

export interface BvMsgBoxOptions {
  title?: string | VNode | Array<VNode>
  titleTag?: string
  size?: string
  centered?: boolean
  scrollable?: boolean
  noFade?: boolean
  noCloseOnBackdrop?: boolean
  noCloseOnEsc?: boolean
  headerBgVariant?: string
  headerBorderVariant?: string
  headerTextVariant?: string
  headerCloseVariant?: string
  headerClass?: string | string[] | Array<any>
  bodyBgVariant?: string
  bodyBorderVariant?: string
  bodyTextVariant?: string
  bodyClass?: string | string[] | Array<any>
  footerBgVariant?: string
  footerBorderVariant?: string
  footerTextVariant?: string
  footerClass?: string | string[] | Array<any>
  headerCloseLabel?: string
  buttonSize?: string
  cancelTitle?: string
  cancelVariant?: string
  okTitle?: string
  okVariant?: string
  // Catch all
  [key: string]: any
}

export interface BvModalMsgBoxResolver {
  (event: BvModalEvent): any
}

export interface BvModalMsgBoxShortcutMethod {
  (message: string | Array<VNode>, options?: BvMsgBoxOptions): Promise<BvMsgBoxData>
  // Future
  // (options?: BvMsgBoxOptions): Promise<BvMsgBoxData>
  // (message: string | Array<VNode>, title: string | Array<VNode>, options?: BvMsgBoxOptions): Promise<BvMsgBoxData>
}

// Not yet documented or implemented (Future)
// export interface BvModalMsgBoxMethod {
//   (options: BvMsgBoxOptions, resolver: BvModalMsgBoxResolver): Promise<BvMsgBoxData>
//   (message: string | Array<VNode>, options: BvMsgBoxOptions, resolver: BvModalMsgBoxResolver): Promise<BvMsgBoxData>
//   (message: string | Array<VNode>, title: string | Array<VNode>, options: BvMsgBoxOptions, resolver: BvModalMsgBoxResolver): Promise<BvMsgBoxData>
// }

export interface BvModal {
  // Show OK MsgBox
  msgBoxOk: BvModalMsgBoxShortcutMethod

  // Show Confirm MsgBox
  msgBoxConfirm: BvModalMsgBoxShortcutMethod

  // Show a modal by id
  show: (id: string) => void

  // Hide a modal by id
  hide: (id: string) => void
}

// --- Vue prototype injections ---
declare module 'vue/types/vue' {
  interface Vue {
    // Modal injection
    readonly $bvModal: BvModal
  }
}
