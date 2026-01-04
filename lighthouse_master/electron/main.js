const { app, BrowserWindow } = require('electron');
const path = require('path');

function createWindow() {
  const win = new BrowserWindow({
    width: 1280,
    height: 800,
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
    },
    autoHideMenuBar: true, // Clean look
    title: 'Lighthouse Master',
    icon: path.join(__dirname, '../assets/icon/icon.png'), // Best effort icon
  });

  // Load the built Flutter Web app
  // output is in ../build/web/index.html relative to this file
  win.loadFile(path.join(__dirname, '../build/web/index.html'));
}

app.whenReady().then(() => {
  createWindow();

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      createWindow();
    }
  });
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});
