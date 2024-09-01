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

    func submit() {
        if self.dones.isEmpty {
            return
        }

        let fileManager = FileManager.default

        // create data
        var data = Data()
        data.append("tasks:\n".data(using: .utf8)!)
        for task in self.dones {
            // title
            data.append("  - title: \"\(task.title)\"\n".data(using: .utf8)!)
            // detail
            if !task.detail.isEmpty {
                data.append("    detail: |-\n".data(using: .utf8)!)
                for line in task.detail.split(whereSeparator: \.isNewline) {
                    data.append("      \(line)\n".data(using: .utf8)!)
                }
            }
            // labels
            if !task.labels.isEmpty {
                data.append("    labels:\n".data(using: .utf8)!)
                for label in task.labels {
                    data.append("      - \(label.title)\n".data(using: .utf8)!)
                }
            }
        }

        // create directory
        let rootDirectory = NSHomeDirectory() + "/Documents/TaskRecorder"
        if !fileManager.fileExists(atPath: rootDirectory) {
            do {
                try fileManager.createDirectory(atPath: rootDirectory, withIntermediateDirectories: false, attributes: nil)
            } catch _ {
                // TODO: show error message
            }
        }

        // create file
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd-HHmm"
        if !FileManager.default.createFile(
            atPath: rootDirectory + "/" + dateFormatter.string(from: Date()) + ".yml",
            contents: data,
            attributes: nil)
        {
            // TODO: show error message
            return
        }

        self.dones.removeAll()
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
