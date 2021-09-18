import AppKit

class Menu: NSObject {
  private var statusItem: NSStatusItem!
  private var menu: NSMenu!

  typealias MenuItemClickedCallback = () -> Void
  var onQuit: MenuItemClickedCallback = {}

  override init() {
    super.init()

    self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    self.statusItem.button?.title = "PRs"

    self.menu = NSMenu()
    // Quit
    self.menu.addItem(
      NSMenuItem(title: "Quit", action: #selector(self.quit), target: self, keyEquivalent: "")
    )

    self.statusItem.menu = self.menu
  }

  @objc func quit() {
    self.onQuit()
  }
}
