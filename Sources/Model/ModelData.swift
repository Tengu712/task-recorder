import Foundation
import SwiftUI

// NOTE: Environmentに利用するため@Observableマクロを適用する。
@Observable
class ModelData {
    var tasks: [Task]
    var labels: [TaskLabel]

    init(tasks: [Task], labels: [TaskLabel]) {
        self.tasks = tasks
        self.labels = labels
    }
}

// TODO:
func loadModelData() -> ModelData {
    return ModelData(
        tasks: [],
        labels: [
            TaskLabel(title: "foo", color: .red),
            TaskLabel(title: "bar", color: .blue),
        ]
    )
}
