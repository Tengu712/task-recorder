import SwiftUI

struct TaskLabelsPage: View {
    @Environment(ModelData.self) private var modelData

    var body: some View {
        NavigationStack {
            Form {
                List {
                    ForEach(self.modelData.labels) { label in
                        NavigationLink {
                            TaskLabelDetail(label: label)
                        } label: {
                            HStack {
                                TaskLabelBadge(label: label)
                                Spacer()
                                Button {
                                    self.modelData.labels.removeAll(where: { $0.id == label.id })
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .onMove(perform: self.move)
                }
            }
            .formStyle(.grouped)
        }
        .navigationTitle("Labels")
        .scrollContentBackground(.hidden)
        .toolbar {
            Button {
                self.modelData.labels.append(TaskLabel())
            } label: {
                Image(systemName: "plus")
            }
        }
    }

    private func move(fromOffsets source: IndexSet, toOffset destination: Int) {
        self.modelData.labels.move(fromOffsets: source, toOffset: destination)
    }
}
