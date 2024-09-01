import Foundation

// NOTE: TaskDetailで変更を監視するためにObservableObjectにする。
//       TaskDetailで変更がビューに反映されないのは、
//       ModelDataで配列に格納しているために起こる謎仕様。
class Task: ObservableObject, Identifiable {
    let id = UUID()
    @Published var title: String = ""
    @Published var detail: String = ""
    @Published var labels: [TaskLabel] = []
}
