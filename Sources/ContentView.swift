import SwiftUI

struct ContentView: View {
    @State var taskViews: [TaskView] = []
    @State var lastId: Int = 0

    var body: some View {
        VStack {
            // header
            HStack {
                Text("Tasks").font(.largeTitle)
                Spacer()
                Button(action: {
                    self.taskViews.append(TaskView(id: lastId))
                    self.lastId += 1
                }) {
                    Image(systemName: "plus")
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding()

            // list
            List(self.taskViews) { task in
                HStack {
                    task
                    Button(action: {
                        self.taskViews.removeAll(where: {$0.id == task.id})
                    }) {
                        Image(systemName: "trash")
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
            }
        }
        .background(Color.white)
    }
}
