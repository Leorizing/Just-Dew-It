import SwiftUI

struct TaskDetailView: View {
    @Binding var task: d.ToDo?
    @Environment(\.dismiss) var dismiss // Allows us to dismiss the view

    var body: some View {
        if let unwrappedTask = task {
            VStack(alignment: .leading, spacing: 10) {
                Text("Task Details")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 10)

                Text("Title: \(unwrappedTask.title)")
                    .font(.headline)

                Text("Due Date: \(unwrappedTask.formattedDueDate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                HStack {
                    Text("Priority: \(unwrappedTask.priority)")
                        .font(.subheadline)
                    Spacer()
                    Picker("Priority", selection: Binding(
                        get: { unwrappedTask.priority },
                        set: { newValue in task?.priority = newValue }
                    )) {
                        ForEach(1...5, id: \.self) { level in
                            Text("\(level)").tag(level)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 150)
                }
                
                Spacer()
                
                // Done Button at the bottom to close the view
                Button(action: {
                    dismiss() // Dismiss the view
                }) {
                    Text("Done")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }
            .padding()
            .frame(width: 300, height: 250)
        } else {
            Text("No Task Selected")
                .font(.title)
                .foregroundColor(.gray)
        }
    }
}

// PreviewProvider for TaskDetailView
struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a mock task to satisfy the Binding requirement
        TaskDetailView(task: .constant(d.ToDo(title: "Sample Task", dueDate: Date(), priority: 3)))
    }
}
