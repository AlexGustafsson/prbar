import AppKit

class Menu {
  private let store: Store

  private var statusItem: NSStatusItem!
  private var menu: NSMenu!
  private var settingsMenu: NSMenu!
  private var showAuth: Bool = false

  typealias MenuItemClickedCallback = () -> Void
  var onQuit: MenuItemClickedCallback = {}

  init(withStore store: Store) {
    self.store = store

    self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    self.statusItem.button?.title = "PRs"

    self.menu = NSMenu()

    self.settingsMenu = NSMenu()
    let userItem = NSMenuItem(title: "", action: nil, keyEquivalent: "")
    self.store.username.subscribe(onNext:{ value in
      userItem.title = value
    })

    self.settingsMenu.addItem(userItem)
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

  @objc func quit() {
    self.onQuit()
  }

  @objc func authenticate() {

  }
}
