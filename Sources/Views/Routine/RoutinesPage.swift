import SwiftUI

struct RoutinesPage: View {
    @Environment(ModelData.self) private var modelData

    var body: some View {
        @Bindable var modelData = self.modelData
        NavigationStack {
            Form {
                List {
                    ForEach(modelData.routines) { task in
                        NavigationLink {
                            TaskDetail(task: task)
                        } label: {
                            RoutineRow(task: task, src: $modelData.routines)
                        }
                    }
                    .onMove(perform: self.move)
                }
            }
            .formStyle(.grouped)
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("Tasks")
        .toolbar {
            Button {
                self.modelData.routines.append(Task())
            } label: {
                Image(systemName: "plus")
            }
        }
    }

    private func move(fromOffsets source: IndexSet, toOffset destination: Int) {
        self.modelData.routines.move(fromOffsets: source, toOffset: destination)
    }
}
