import Foundation

private let fileManaer = FileManager.default

let ROOT_DIRECTORY = NSHomeDirectory() + "/Documents/TaskRecorder"

func getFileURLs() -> [URL] {
    if var files = try? fileManaer.contentsOfDirectory(
        at: URL(fileURLWithPath: ROOT_DIRECTORY),
        includingPropertiesForKeys: nil,
        options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
    
    {
        files.sort { a, b in a.absoluteString < b.absoluteString }
        return files
    }
    // TODO: show error message
    return []
}

func trimFileName(from url: URL) -> String {
    if let lastComponent = url.absoluteString.split(separator: "/").last {
        return String(lastComponent)
    } else {
        return url.absoluteString
    }
}
