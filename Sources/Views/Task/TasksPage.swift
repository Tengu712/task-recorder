import SwiftUI

private struct TasksListOr: View {
    @Environment(ModelData.self) private var modelData
    var tasks: [Task]
    let alt: String

    var body: some View {
        ViewOr(flag: self.tasks.isEmpty, alt: self.alt) {
            List {
                ForEach(self.tasks) { task in
                    NavigationLink {
                        TaskDetail(task: task)
                    } label: {
                        TaskRow(task: task)
                    }
                }
                .onMove(perform: self.move)
            }
        }
    }

    private func move(fromOffsets source: IndexSet, toOffset destination: Int) {
        self.modelData.tasks.move(fromOffsets: source, toOffset: destination)
    }
}

struct TasksPage: View {
    @Environment(ModelData.self) private var modelData

    private var pendings: [Task] {
        return self.modelData.tasks.filter({ n in !n.isDone})
    }

    private var dones: [Task] {
        return self.modelData.tasks.filter({ n in n.isDone})
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Pending")) {
                    TasksListOr(tasks: self.pendings, alt: "No tasks pending.")
                }
                Section(header: Text("Done")) {
                    TasksListOr(tasks: self.dones, alt: "No tasks have been done.")
                }
            }
            .formStyle(.grouped)
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
}
