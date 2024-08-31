import SwiftUI

struct TaskLabelBadge: View {
    let label: TaskLabel

    var body: some View {
        Text(self.label.title)
            .font(.subheadline)
            .padding([.top, .bottom], 4)
            .padding([.leading, .trailing], 8)
            .background(self.label.color)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
