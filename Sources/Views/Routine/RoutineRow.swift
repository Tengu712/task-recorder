import SwiftUI

struct RoutineRow: View {
    @Environment(ModelData.self) private var modelData
    @ObservedObject var task: Task
    @Binding var src: [Task]

    var body: some View {
        HStack {
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
