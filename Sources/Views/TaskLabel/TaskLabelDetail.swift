import SwiftUI

struct TaskLabelDetail: View {
    @ObservedObject var label: TaskLabel

    var body: some View {
        ScrollView {
            Form {
                Section(header: Text("Preview")) {
                    TaskLabelBadge(label: self.label)
                }

                Section(header: Text("Settings")) {
                    TextField("Title", text: self.$label.title, prompt: Text("Label title..."))
                    Picker("Color", selection: self.$label.color) {
                        Text("Blue").tag(Color.blue)
                        Text("Cyan").tag(Color.cyan)
                        Text("Gray").tag(Color.gray)
                        Text("Green").tag(Color.green)
                        Text("Indigo").tag(Color.indigo)
                        Text("Orange").tag(Color.orange)
                        Text("Red").tag(Color.red)
                        Text("Yellow").tag(Color.yellow)
                    }
                }
            }
            .formStyle(.grouped)
        }
        .navigationTitle("Label Detail")
    }
}
