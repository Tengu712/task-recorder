import SwiftUI

struct FilesPage: View {
    @Environment(ModelData.self) private var modelData

    var body: some View {
        Form {
            ViewOr(flag: getFileURLs().isEmpty, alt: "No files.") {
                List(getFileURLs(), id: \.self) { url in
                    HStack {
                        Text(trimFileName(from: url))
                        Spacer()
                        ShareLink(item: url) {
                            Image(systemName: "square.and.arrow.up")
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .formStyle(.grouped)
        .navigationTitle("Files")
        .scrollContentBackground(.hidden)
    }
}
