import SwiftUI

struct TaskDetail: View {
    @Environment(ModelData.self) var modelData
    @ObservedObject var task: Task

    private var unattachedLabels: [TaskLabel] {
        return self.modelData.labels.filter({ n in
            !self.task.labels.contains(where: { m in
                m.title == n.title
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
                    ForEach(self.task.labels.indices, id: \.self) { i in
                        HStack {
                            TaskLabelBadge(label: self.task.labels[i])
                            Spacer()
                            Button {
                                self.task.labels.remove(at: i)
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
                    ForEach(self.unattachedLabels.indices, id: \.self) { i in
                        HStack {
                            TaskLabelBadge(label: self.unattachedLabels[i])
                            Spacer()
                            Button {
                                self.task.labels.append(self.unattachedLabels[i])
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
