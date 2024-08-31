import SwiftUI

struct ContentView: View {
    @Environment(ModelData.self) private var modelData

    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink {
                    TasksPage()
                } label: {
                    HStack {
                        Image(systemName: "tray.fill")
                        Text("Tasks")
                    }
                }

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
