import Foundation

private let fileManager = FileManager.default
private let rootDirectory = NSHomeDirectory() + "/Documents/TaskRecorder"

// NOTE: Environmentに利用するため@Observableマクロを適用する。
@Observable
class ModelData: Encodable {
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
    let modelData = ModelData(pendings: [], dones: [], labels: [])

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

    if let pendings = json["_pendings"] as? [[String: Any]] {
        for n in pendings {
            modelData.pendings.append(Task.loadFrom(dict: n))
        }
    }
    if let dones = json["_dones"] as? [[String: Any]] {
        for n in dones {
            modelData.dones.append(Task.loadFrom(dict: n))
        }
    }
    if let labels = json["_labels"] as? [[String: Any]] {
        for n in labels {
            modelData.labels.append(TaskLabel.loadFrom(dict: n))
        }
    }
    
    return modelData
}
