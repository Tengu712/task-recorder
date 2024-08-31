import Foundation
import SwiftUI

// NOTE: TaskLabelDetailで変更を監視するためにObservableObjectにする。
//       TaskLabelDetailで変更がビューに反映されないのは、
//       ModelDataで配列に格納しているために起こる謎仕様。
class TaskLabel: ObservableObject {
    @Published var title: String = "Label"
    @Published var color: Color = Color.gray
}
