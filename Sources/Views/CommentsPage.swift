import SwiftUI

struct CommentsPage: View {
    @Environment(ModelData.self) private var modelData

    var body: some View {
        @Bindable var modelData = self.modelData
        Form {
            TextEditor(text: $modelData.comments)
                .font(.body)
                .frame(minHeight: 320)
                .textEditorStyle(.plain)
        }
        .formStyle(.grouped)
        .navigationTitle("Comments")
        .scrollContentBackground(.hidden)
    }
}
