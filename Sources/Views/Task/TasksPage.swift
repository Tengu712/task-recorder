import SwiftUI

struct TasksPage: View {
    @Environment(ModelData.self) private var modelData

    var body: some View {
        @Bindable var modelData = self.modelData
        NavigationStack {
            Form {
                Section(header: Text("Pending")) {
                    TasksListOr(src: $modelData.pendings, dst: $modelData.dones, icon: "circle", alt: "No tasks pending.")
                }
                Section(header: Text("Done")) {
                    TasksListOr(src: $modelData.dones, dst: $modelData.pendings, icon: "circle.fill", alt: "No tasks have been done.")
                }
            }
            .formStyle(.grouped)
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("Tasks")
        .toolbar {
            Button {
                self.modelData.pendings.append(Task())
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}
