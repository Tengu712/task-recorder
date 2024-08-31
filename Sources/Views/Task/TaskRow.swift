import SwiftUI

struct TaskRow: View {
    @ObservedObject var task: Task

    var body: some View {
        HStack {
            Button {
                self.task.isDone.toggle()
            } label: {
                Image(systemName: self.task.isDone ? "circle.fill" : "circle")
            }
            .buttonStyle(PlainButtonStyle())

            Text(self.task.title)

            Spacer()

            HStack {
                ForEach(self.task.labels, id: \.self) { label in
                    TaskLabelBadge(label: label)
                }
            }
        }
    }
}
