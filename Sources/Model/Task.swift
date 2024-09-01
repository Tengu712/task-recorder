import Foundation

// NOTE: TaskDetailで変更を監視するためにObservableObjectにする。
//       TaskDetailで変更がビューに反映されないのは、
//       ModelDataで配列に格納しているために起こる謎仕様。
class Task: ObservableObject, Identifiable, Encodable {
    let id = UUID()
    @Published var title: String = ""
    @Published var detail: String = ""
    @Published var labels: [TaskLabel] = []

    static func loadFrom(dict: [String: Any]) -> Task {
        let task = Task()
        if let title = dict["title"] as? String {
            task.title = title
        }
        if let detail = dict["detail"] as? String {
            task.detail = detail
        }
        if let labels = dict["labels"] as? [[String: Any]] {
            for n in labels {
                task.labels.append(TaskLabel.loadFrom(dict: n))
            }
        }
        return task
    }
}
