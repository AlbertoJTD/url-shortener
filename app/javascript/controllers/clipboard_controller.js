import { Controller } from "@hotwired/stimulus"
import ClipboardJS from 'clipboard'

// Connects to data-controller="clipboard"
export default class extends Controller {
  static values = {
    success: { type: String, default: 'Copied!'},
    failure: { type: String, default: 'Failed to copy!'}
  }

  connect() {
    this.clipboard = new ClipboardJS(this.element);

    this.clipboard.on('success', (e) => this.tooltip(this.successValue) );
    this.clipboard.on('error', (e) => this.tooltip(this.failureValue) );
  }

  tooltip(message) {
    tippy(this.element, {
      content: message,
      showOnCreate: true,
      onHidden: (instance) => {
        instance.destroy();
      },
      animation: 'scale'
    });
  }

  disconnect() {
    this.clipboard.destroy();
  }
}
