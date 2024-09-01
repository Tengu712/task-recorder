import SwiftUI

struct TaskRow: View {
    @ObservedObject var task: Task

    var body: some View {
        HStack {
            Text(self.task.title)
            Spacer()
            ForEach(self.task.labels) { label in
                TaskLabelBadge(label: label)
            }
        }
    }
}
