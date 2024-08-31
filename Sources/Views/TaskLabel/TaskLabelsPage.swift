import SwiftUI

struct TaskLabelsPage: View {
    @Environment(ModelData.self) var modelData

    var body: some View {
        NavigationStack {
            List {
                ForEach(self.modelData.labels.indices, id: \.self) { i in
                    NavigationLink {
                        TaskLabelDetail(label: self.modelData.labels[i])
                    } label: {
                        HStack {
                            TaskLabelBadge(label: self.modelData.labels[i])
                            Spacer()
                            Button {
                                self.modelData.labels.remove(at: i)
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
