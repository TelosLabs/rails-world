if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/service-worker.js', { scope: '/' })
    .then(() => navigator.serviceWorker.ready)
}
