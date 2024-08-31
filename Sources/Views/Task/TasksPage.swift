import SwiftUI

struct TasksPage: View {
    @Environment(ModelData.self) var modelData

    var body: some View {
        NavigationStack {
            List {
                ForEach(self.modelData.tasks.indices, id: \.self) { i in
                    NavigationLink {
                        TaskDetail(task: self.modelData.tasks[i])
                    } label: {
                        TaskRow(task: self.modelData.tasks[i])
                    }
                }
                .onMove(perform: self.move)
            }
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("Tasks")
        .toolbar {
            Button {
                self.modelData.tasks.append(Task())
            } label: {
                Image(systemName: "plus")
            }
        }
    }

    private func move(fromOffsets source: IndexSet, toOffset destination: Int) {
        self.modelData.tasks.move(fromOffsets: source, toOffset: destination)
    }
}
