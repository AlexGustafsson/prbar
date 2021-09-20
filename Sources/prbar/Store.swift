import AppKit
import os
import KeychainAccess
import OctoKit

private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "UI/Store")
private let applicationName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""

class Store {
  private let client: Octokit
  public private(set) var user: User?

  convenience init?(fromKeychain keychain: Keychain) {
    guard let token = keychain[applicationName] else {
      return nil
    }

    self.init(fromToken: token)
  }

  init(fromToken token: String) {
    let config = TokenConfiguration(token)
    self.client = Octokit(config)
  }

  func connect() {
    self.client.me() { response in
      switch response {
        case .success(let user):
          self.user = user
        case .failure(let error):
          logger.error("Unable to authenticate: \(error.localizedDescription, privacy: .public)")
      }
    }
  }
}
