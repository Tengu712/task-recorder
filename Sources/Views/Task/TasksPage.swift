import SwiftUI

struct TasksPage: View {
    @Environment(ModelData.self) var modelData

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
                    ViewOr(flag: self.pendings.isEmpty, alt: "No tasks pending.") {
                        ForEach(self.pendings.indices, id: \.self) { i in
                            NavigationLink {
                                TaskDetail(task: self.pendings[i])
                            } label: {
                                TaskRow(task: self.pendings[i])
                            }
                        }
                        .onMove(perform: self.move)
                    }
                }

                Section(header: Text("Done")) {
                    ViewOr(flag: self.dones.isEmpty, alt: "No tasks have been done.") {
                        ForEach(self.dones.indices, id: \.self) { i in
                            NavigationLink {
                                TaskDetail(task: self.dones[i])
                            } label: {
                                TaskRow(task: self.dones[i])
                            }
                        }
                        .onMove(perform: self.move)
                    }
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

    private func move(fromOffsets source: IndexSet, toOffset destination: Int) {
        self.modelData.tasks.move(fromOffsets: source, toOffset: destination)
    }
}
