import AppKit

class Menu: NSObject {
  private var statusItem: NSStatusItem!
  private var menu: NSMenu!
  private var settingsMenu: NSMenu!
  private var showAuth: Bool = false
  private var userItem: NSMenuItem?

  typealias MenuItemClickedCallback = () -> Void
  var onQuit: MenuItemClickedCallback = {}

  override init() {
    super.init()

    self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    self.statusItem.button?.title = "PRs"

    self.menu = NSMenu()

    self.settingsMenu = NSMenu()
    self.userItem = NSMenuItem(title: "Username", action: nil, keyEquivalent: "")
    self.settingsMenu.addItem(self.userItem!)
    self.settingsMenu.addItem(
      NSMenuItem(title: "Quit", action: #selector(self.quit), target: self, keyEquivalent: "")
    )
    let settingsItem = NSMenuItem(title: "Settings", action: nil, keyEquivalent: "")
    self.menu.setSubmenu(self.settingsMenu, for: settingsItem)
    self.menu.addItem(settingsItem)

    self.statusItem.menu = self.menu
  }

  func promptForAuth() {
    if !self.showAuth {
      self.menu.addItem(
        NSMenuItem(title: "Authenticate", action: #selector(self.authenticate), target: self, keyEquivalent: "")
      )
      self.showAuth = true
      self.statusItem.menu = self.menu
    }
  }

  func setUsername(_ username: String) {
    self.userItem!.title = username
  }

  @objc func quit() {
    self.onQuit()
  }

  @objc func authenticate() {

  }
}
