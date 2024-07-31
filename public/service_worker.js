self.addEventListener('push', (event) => {
  var message = event.data;

  event.waitUntil(self.registration.showNotification('Example'));
});