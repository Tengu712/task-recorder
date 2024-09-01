import Foundation

// NOTE: Environmentに利用するため@Observableマクロを適用する。
@Observable
class ModelData {
    var pendings: [Task]
    var dones: [Task]
    var labels: [TaskLabel]

    init(pendings: [Task], dones: [Task], labels: [TaskLabel]) {
        self.pendings = pendings
        self.dones = dones
        self.labels = labels
    }
}

// TODO:
func loadModelData() -> ModelData {
    return ModelData(
        pendings: [],
        dones: [],
        labels: []
    )
}
