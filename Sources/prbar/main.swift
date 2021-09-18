import AppKit
import ArgumentParser
import Foundation
import os

private let logger = Logger(subsystem: "prbar", category: "Main")

struct Prbar: ParsableCommand {
  static let configuration = CommandConfiguration(abstract: "Interact with prbar")

  func validate() throws {

  }

  mutating func run() throws {
    logger.info("Initiating application")
    let app = NSApplication.shared

    let appDelegate = AppDelegate()
    app.delegate = appDelegate

    logger.info("Starting application")
    app.run()

    logger.info("Application closed")
  }
}

Prbar.main()
