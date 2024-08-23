import SwiftUI

#if os(macOS)
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
#endif

@main
struct MainApp: App {
#if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
#endif

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
