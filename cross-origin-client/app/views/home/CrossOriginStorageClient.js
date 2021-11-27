class CrossOriginStorageClient {
  constructor (window, iframeContainerId) {
    this.window = window;
    this.storageWindow = null;
    this.storageBaseUrl = 'localhost:3000'
    this.loadPromise = this.loadStorageIframe(iframeContainerId);
  }

  loadStorageIframe (iframeContainerId) {
    return new Promise((resolve) => {
      const containerEl = window.document.getElementById(iframeContainerId);
      const storageIframe = window.document.createElement('iframe');
      this.window.addEventListener('message', (event) => {
        if (event.data === 'loaded') {
          this.storageWindow = storageIframe.contentWindow;
          resolve();
        }
      });
      storageIframe.src = `${this.storageBaseUrl}/cross_origin_storage`;
      if (containerEl) {
        containerEl.appendChild(storageIframe);
      }
    });
  }

  // set key, value to the cross origin storage
  async set (key, value) {
    await this.loadPromise;
    if (this.storageWindow) {
      this.storageWindow.postMessage({
        action: 'set',
        key,
        value,
      }, this.storageBaseUrl);
    }
  }

  // get key, value from the cross origin storage
  async get (key) {
    await this.loadPromise;
    return new Promise((resolve) => {
      const handler = (event) => {
        if (event.origin !== this.storageBaseUrl) {
          return;
        }
        const { action, key: returningKey, value } = event.data;
        if (action === 'returnData' && key === returningKey) {
          this.window.removeEventListener('message', handler);
          resolve(JSON.stringify(value));
        }
      };
      this.window.addEventListener('message', handler);
    });
  }
}

export default CrossOriginStorageClient;
