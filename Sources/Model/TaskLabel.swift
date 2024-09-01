import Foundation
import SwiftUI

private struct ColorOriginal {
    let key: String
    let value: Color
}
private let COLOR_ORIGINALS = [
    ColorOriginal(key: "Blue", value: Color.blue),
    ColorOriginal(key: "Cyan", value: Color.cyan),
    ColorOriginal(key: "Gray", value: Color.gray),
    ColorOriginal(key: "Green", value: Color.green),
    ColorOriginal(key: "Indigo", value: Color.indigo),
    ColorOriginal(key: "Orange", value: Color.orange),
    ColorOriginal(key: "Red", value: Color.red),
    ColorOriginal(key: "Yellow", value: Color.yellow),
]
private let COLOR_MAP = COLOR_ORIGINALS.reduce(into: [:], { result, n in
    result[n.key] = n.value
})
let COLOR_KEYS = COLOR_ORIGINALS.map({ n in n.key })

// NOTE: TaskLabelDetailで変更を監視するためにObservableObjectにする。
//       TaskLabelDetailで変更がビューに反映されないのは、
//       ModelDataで配列に格納しているために起こる謎仕様。
class TaskLabel: ObservableObject, Identifiable, Encodable {
    let id = UUID()
    @Published var title: String = "Label"
    @Published var colorKey: String = "gray"

    var color: Color {
        return COLOR_MAP[self.colorKey] ?? Color.gray
    }

    static func loadFrom(dict: [String: Any]) -> TaskLabel {
        let label = TaskLabel()
        if let title = dict["title"] as? String {
            label.title = title
        }
        if let colorKey = dict["colorKey"] as? String {
            label.colorKey = colorKey
        }
        return label
    }
}
