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
    @State private var modelData = loadModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(self.modelData)
                // NOTE: ウィンドウが閉じられたときにmodelDataを保存する
                .onReceive(NotificationCenter.default.publisher(for: NSWindow.willCloseNotification)) { _ in
                    self.modelData.save()
                }
        }
    }
}
