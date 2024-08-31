import SwiftUI

struct ViewOr<Content>: View
where
    Content: View
{
    let flag: Bool
    let alt: String
    let content: Content

    init(flag: Bool, alt: String, @ViewBuilder content: () -> Content) {
        self.flag = flag
        self.alt = alt
        self.content = content()
    }

    var body: some View {
        Group {
            if self.flag {
                Text(self.alt)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                self.content
            }
        }
    }
}
