import SwiftUI

struct TaskLabelDetail: View {
    @ObservedObject var label: TaskLabel

    var body: some View {
        Form {
            Section(header: Text("Preview")) {
                TaskLabelBadge(label: self.label)
            }

            Section(header: Text("Settings")) {
                TextField("Title", text: self.$label.title, prompt: Text("Label title..."))
                Picker("Color", selection: self.$label.colorKey) {
                    ForEach(COLOR_KEYS, id: \.self) { key in
                        Text(key).tag(key)
                    }
                }
            }
        }
        .formStyle(.grouped)
        .navigationTitle("Label Detail")
    }
}
