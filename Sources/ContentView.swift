import SwiftUI

struct ContentView: View {
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

                NavigationLink {
                    CommentsPage()
                } label: {
                    HStack {
                        Image(systemName: "list.clipboard")
                        Text("Comments")
                    }
                }

                NavigationLink {
                    RoutinesPage()
                } label: {
                    HStack {
                        Image(systemName: "cup.and.saucer")
                        Text("Routines")
                    }
                }

                NavigationLink {
                    FilesPage()
                } label: {
                    HStack {
                        Image(systemName: "folder")
                        Text("Files")
                    }
                }
            }
            .scrollContentBackground(.hidden)
        } detail: {
        }
        .navigationTitle("Task Recorder")
    }
}
