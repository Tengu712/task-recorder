import SwiftUI

struct ContentView: View {
    @Environment(ModelData.self) var modelData

    var body: some View {
        NavigationSplitView {
            List {
                // Tasks
                NavigationLink {
                    TasksPage()
                } label: {
                    HStack {
                        Image(systemName: "tray.fill")
                        Text("Tasks")
                    }
                }
                // Labels
                NavigationLink {
                    TaskLabelsPage()
                } label: {
                    HStack {
                        Image(systemName: "tag.fill")
                        Text("Labels")
                    }
                }
                // TODO:
            }
            .scrollContentBackground(.hidden)
        } detail: {
        }
        .navigationTitle("Task Recorder")
    }
}
