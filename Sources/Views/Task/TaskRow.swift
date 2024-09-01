import SwiftUI

struct TaskRow: View {
    @Environment(ModelData.self) private var modelData
    @ObservedObject var task: Task
    @Binding var src: [Task]
    @Binding var dst: [Task]
    let icon: String

    var body: some View {
        HStack {
            Button {
                self.src.removeAll(where: { $0.id == self.task.id })
                self.dst.append(self.task)
            } label: {
                Image(systemName: self.icon)
            }
            .buttonStyle(PlainButtonStyle())

            Text(self.task.title)

            Spacer()

            ForEach(self.task.labelIds, id: \.self) { id in
                TaskLabelBadge(label: self.modelData.getLabel(id: id))
            }

            Button {
                self.src.removeAll(where: { $0.id == self.task.id })
            } label: {
                Image(systemName: "trash")
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
