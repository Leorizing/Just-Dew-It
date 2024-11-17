import SwiftUI

struct ContentView: View {
    @State private var tasks: [d.ToDo] = [
        d.ToDo(title: "Sample Task", dueDate: Date(), priority: 3) // Sample data for testing
    ]
    @State private var showingAddTask = false
    @State private var selectedTask: d.ToDo? = nil
    @State private var showingPopover = false

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.green.opacity(0.3),
                    Color.purple.opacity(0.3),
                    Color.blue.opacity(0.3)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack {
                Text("Just Dew It")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 50)

                ScrollView {
                    VStack(spacing: 10) {
                        // Display each task
                        ForEach(tasks) { task in
                            HStack {
                                if task.priority == 1 {
                                    Image(systemName: "calendar.badge.exclamationmark")
                                        .foregroundColor(.red)
                                }

                                VStack(alignment: .leading) {
                                    Text(task.title)
                                        .font(.headline)
                                        .foregroundColor(.white)

                                    Text(task.formattedDueDate)
                                        .foregroundColor(.white.opacity(0.7))
                                        .font(.subheadline)
                                }
                                .padding(10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.black.opacity(0.2))
                                .cornerRadius(10)
                                .shadow(radius: 3)
                            }
                            .onTapGesture {
                                // Set selectedTask and show popover
                                selectedTask = task
                                showingPopover = true
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .popover(isPresented: $showingPopover) {
                    // Directly display TaskDetailView with selectedTask
                    TaskDetailView(task: $selectedTask)
                }

                Spacer()

                Button(action: {
                    showingAddTask.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .frame(width: 70, height: 70)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(35)
                        .overlay(
                            RoundedRectangle(cornerRadius: 35)
                                .stroke(Color.white.opacity(0.4), lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                        .padding(.bottom, 40)
                }
                .sheet(isPresented: $showingAddTask) {
                    AddTaskView(tasks: $tasks)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ContentView()
}
