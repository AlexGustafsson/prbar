import AppKit
import OctoKit
import KeychainAccess
import os

private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "UI/AppDelegate")
private let applicationName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""

class AppDelegate: NSObject, NSApplicationDelegate {
  private var menu: Menu?

  func applicationDidFinishLaunching(_: Notification) {
    let menu = Menu()
    menu.onQuit = {
      NSApplication.shared.terminate(nil)
    }
    self.menu = menu

    let keychain = Keychain(service: Bundle.main.bundleIdentifier!)

    var token = keychain[applicationName]
    if token == nil {
      token = AuthPrompt().prompt()
      do {
        try keychain
          .label("prbar (github.com)")
          .comment("GitHub Private Access Token")
          .set(token!, key: applicationName)
      } catch let error {
        logger.error("Failed to set GitHub token: \(error.localizedDescription)")
      }
    }

    let config = TokenConfiguration(token)
    let client = Octokit(config)
    client.me() { response in
      switch response {
      case .success(let user):
        menu.setUsername(user.login!)
      case .failure(let error):
      logger.error("Unable to authenticated: \(error.localizedDescription)")
        DispatchQueue.main.async {
          AuthAlert(error: error).runModal()
          NSApplication.shared.terminate(nil)
        }
      }
    }
  }

  func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication) -> Bool { false }
}

class AuthAlert: NSAlert {
  init(error: Error) {
    super.init()
    self.messageText = "Unable to authenticate"
    self.informativeText =
      "Unable to authenticate you on GitHub using the provided token."
    self.addButton(withTitle: "OK")
    self.alertStyle = .warning
  }
}

class AuthPrompt: NSAlert {
  var text: NSTextField!
  override init() {
    super.init()
    self.messageText = "Authenticate"
    self.informativeText =
      "Provide a personal access token for GitHub."
    self.addButton(withTitle: "OK")
    self.alertStyle = .informational

    self.text = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
    self.accessoryView = self.text
  }

  func prompt() -> String {
    self.runModal()
    return self.text.stringValue
  }
}
