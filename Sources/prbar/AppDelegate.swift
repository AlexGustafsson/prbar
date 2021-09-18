import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
  private var menu: Menu?

  func applicationDidFinishLaunching(_: Notification) {
    let menu = Menu()
    menu.onQuit = {
      NSApplication.shared.terminate(nil)
    }
    self.menu = menu
  }

  func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication) -> Bool { false }
}
