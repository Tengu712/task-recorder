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
        ScrollView {
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
                    if self.task.labels.isEmpty {
                        Text("No label attached.")
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
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
                    if self.unattachedLabels.isEmpty {
                        Text("No label available.")
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
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
        }
        .navigationTitle("Task Detail")
    }
}
