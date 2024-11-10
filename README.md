<img width="540" src="https://github.com/user-attachments/assets/cabfd8f3-be7f-492e-b8cd-2979a81453d1">

# electron-5-mavericks

Code wrapper to get Electron 5.0.0 (v5.0.0-nightly.20190122) working on OS X 10.9 Mavericks. This version of Electron is based on Chromium 71.0.3578.98 and is a bit newer than the last official build for 10.9 (Electron 3, Chromium 66.0.3359.181).

To use this, download the Electron build's frameworks (Show Package Contents -> Frameworks) from https://github.com/electron/nightlies/releases/download/v5.0.0-nightly.20190122/electron-v5.0.0-nightly.20190122-darwin-x64.zip and replace your desired application's Frameworks. You may also want to copy over Electron.asar from Resources.

If you are building an Electron application, you can target Electron 5.0.0 and copy over the frameworks once your application is built.

To run an application, use `DYLD_INSERT_LIBRARIES=/path/to/libMavericks.dylib /path/to/application/bin` or use [insert_dylib](https://github.com/tyilo/insert_dylib) to permanently add the dylib.

## Tested applications
- Visual Studio Code v1.39 (Injected wrapper only, stock Electron)
- Discord 0.0.256 (Launches, but no longer functional with current Discord client Javascript)
