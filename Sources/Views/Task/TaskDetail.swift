import SwiftUI

struct TaskDetail: View {
    @Environment(ModelData.self) private var modelData
    @ObservedObject var task: Task

    private var unattachedLabels: [TaskLabel] {
        return self.modelData.labels.filter({ n in
            !self.task.labels.contains(where: { m in
                m.id == n.id
            })
        })
    }

    var body: some View {
        Form {
            Section() {
                TextField("Title", text: self.$task.title, prompt: Text("Task title..."))
            }

            Section(header: Text("Detail")) {
                TextEditor(text: self.$task.detail)
                    .font(.body)
                    .frame(minHeight: 80)
                    .textEditorStyle(.plain)
            }

            Section(header: Text("Labels")) {
                ViewOr(flag: self.task.labels.isEmpty, alt: "No labels attached.") {
                    ForEach(self.task.labels) { label in
                        HStack {
                            TaskLabelBadge(label: label)
                            Spacer()
                            Button {
                                self.task.labels.removeAll(where: { $0.id == label.id })
                            } label: {
                                Image(systemName: "minus.circle")
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }

            Section(header: Text("Unattached Labels")) {
                ViewOr(flag: self.unattachedLabels.isEmpty, alt: "No labels available.") {
                    ForEach(self.unattachedLabels) { label in
                        HStack {
                            TaskLabelBadge(label: label)
                            Spacer()
                            Button {
                                self.task.labels.append(label)
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
        }
        .formStyle(.grouped)
        .navigationTitle("Task Detail")
    }
}
