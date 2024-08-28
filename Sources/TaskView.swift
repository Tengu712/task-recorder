import SwiftUI

struct TaskView: View, Identifiable {
    let id: Int

    @State private var text: String

    init(id: Int) {
        self.id = id
        self.text = ""
    }

    var body: some View {
        HStack {
            TextField("", text: $text)
            Spacer()
            Button(action: {
            }) {
                Image(systemName: "plus")
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
