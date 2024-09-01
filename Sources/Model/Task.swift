import Foundation

// NOTE: TaskDetailで変更を監視するためにObservableObjectにする。
//       TaskDetailで変更がビューに反映されないのは、
//       ModelDataで配列に格納しているために起こる謎仕様。
class Task: ObservableObject, Identifiable, Encodable {
    let id = UUID()
    @Published var title: String = ""
    @Published var detail: String = ""
    @Published var labelIds: [UUID] = []

    // NOTE: TaskLabelの整合性を取るためにTaskLabel.idの新旧比較辞書を参照する。
    static func loadFrom(dict: [String: Any], labelDict: [String: UUID]) -> Task {
        let task = Task()
        if let title = dict["title"] as? String {
            task.title = title
        }
        if let detail = dict["detail"] as? String {
            task.detail = detail
        }
        if let labelIds = dict["labelIds"] as? [String] {
            for id in labelIds {
                if let nid = labelDict[id] {
                    task.labelIds.append(nid)
                }
            }
        }
        return task
    }
}
