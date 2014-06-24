
chrome.app.runtime.onLaunched.addListener(function(launchData) {
  chrome.app.window.create('dart_chrome_app_spike.html', {
    'id': '_mainWindow', 'bounds': {'width': 800, 'height': 600 }
  });
});
