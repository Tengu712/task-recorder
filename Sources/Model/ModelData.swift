import Foundation

private let fileManager = FileManager.default
private let rootDirectory = NSHomeDirectory() + "/Documents/TaskRecorder"

// NOTE: Environmentに利用するため@Observableマクロを適用する。
@Observable
class ModelData: Encodable {
    var labels: [TaskLabel] = []
    var pendings: [Task] = []
    var dones: [Task] = []
    var comments: String = ""

    func getLabel(id: UUID) -> TaskLabel {
        // NOTE: ロード時に整合性を取っているため!を付けて良い。
        return self.labels.first(where: { n in n.id == id })!
    }

    func submit() {
        if self.dones.isEmpty {
            return
        }

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
            if !task.labelIds.isEmpty {
                data.append("    labels:\n".data(using: .utf8)!)
                for id in task.labelIds {
                    data.append("      - \(self.getLabel(id: id).title)\n".data(using: .utf8)!)
                }
            }
        }
        if !self.comments.isEmpty {
            data.append("comments: |-\n".data(using: .utf8)!)
            for line in self.comments.split(whereSeparator: \.isNewline) {
                data.append("  \(line)\n".data(using: .utf8)!)
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
        self.comments = ""
    }

    func save() {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else {
            // TODO: show error message
            return
        }
        if !FileManager.default.createFile(
            atPath: rootDirectory + "/ModelData.json",
            contents: data,
            attributes: nil)
        {
            // TODO: show error message
            return
        }
    }
}

func loadModelData() -> ModelData {
    let modelData = ModelData()

    // create directory
    if !fileManager.fileExists(atPath: rootDirectory) {
        do {
            try fileManager.createDirectory(atPath: rootDirectory, withIntermediateDirectories: false, attributes: nil)
        } catch _ {
            // TODO: show error message
        }
    }

    // if ModelData.json not found
    if !fileManager.fileExists(atPath: rootDirectory + "/ModelData.json") {
        return modelData
    }
    // load ModelData.json as Data
    guard let data = try? Data(contentsOf: URL(fileURLWithPath:rootDirectory + "/ModelData.json")) else {
        return modelData
    }
    // load ModelData.json as [:]
    guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
        return modelData
    }

    var labelDict = [String: UUID]()
    if let labels = json["_labels"] as? [[String: Any]] {
        for n in labels {
            modelData.labels.append(TaskLabel.loadFrom(dict: n, labelDict: &labelDict))
        }
    }
    if let pendings = json["_pendings"] as? [[String: Any]] {
        for n in pendings {
            modelData.pendings.append(Task.loadFrom(dict: n, labelDict: labelDict))
        }
    }
    if let dones = json["_dones"] as? [[String: Any]] {
        for n in dones {
            modelData.dones.append(Task.loadFrom(dict: n, labelDict: labelDict))
        }
    }
    if let comments = json["_comments"] as? String {
        modelData.comments = comments
    }
    
    return modelData
}
