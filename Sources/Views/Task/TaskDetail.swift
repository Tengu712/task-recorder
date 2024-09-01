import SwiftUI

struct TaskDetail: View {
    @Environment(ModelData.self) private var modelData
    @ObservedObject var task: Task

    private var attachedLabels: [TaskLabel] {
        return self.modelData.labels.filter({ n in
            self.task.labelIds.contains(where: { m in
                m == n.id
            })
        })
    }

    private var unattachedLabels: [TaskLabel] {
        return self.modelData.labels.filter({ n in
            !self.task.labelIds.contains(where: { m in
                m == n.id
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
                ViewOr(flag: self.attachedLabels.isEmpty, alt: "No labels attached.") {
                    ForEach(self.attachedLabels) { label in
                        HStack {
                            TaskLabelBadge(label: label)
                            Spacer()
                            Button {
                                self.task.labelIds.removeAll(where: { $0 == label.id })
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
                                self.task.labelIds.append(label.id)
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
