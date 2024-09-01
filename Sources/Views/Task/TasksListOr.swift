import SwiftUI

struct TasksListOr: View {
    @Binding var src: [Task]
    @Binding var dst: [Task]
    let icon: String
    let alt: String

    var body: some View {
        ViewOr(flag: self.src.isEmpty, alt: self.alt) {
            List {
                ForEach(self.src) { task in
                    HStack {
                        Button {
                            src.removeAll(where: { $0.id == task.id })
                            dst.append(task)
                        } label: {
                            Image(systemName: self.icon)
                        }
                        .buttonStyle(PlainButtonStyle())

                        NavigationLink {
                            TaskDetail(task: task)
                        } label: {
                            TaskRow(task: task)
                        }
                    }
                }
                .onMove(perform: self.move)
            }
        }
    }

    private func move(fromOffsets source: IndexSet, toOffset destination: Int) {
        self.src.move(fromOffsets: source, toOffset: destination)
    }
}
