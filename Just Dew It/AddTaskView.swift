//
//  AddTaskView.swift
//  Just Dew It
//
//  Created by J.D Aviles on 11/17/24.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var tasks: [d.ToDo]

    @State private var taskTitle: String = ""
    @State private var dueDate: Date = Date()
    @State private var dueTime: Date = Date()
    @State private var priority: Int = 5
    @FocusState private var isTitleFocused: Bool

    var body: some View {
        NavigationView {
            Form {
                Section(header: HStack {
                    Image(systemName: "pencil.and.list.clipboard")
                    Text("Task")
                }) {
                    TextField("Give it a name", text: $taskTitle)
                        .focused($isTitleFocused)
                        .onAppear {
                            isTitleFocused = true
                        }
                }

                Section(header: HStack {
                    Image(systemName: "calendar.badge.clock")
                    Text("Due Date & Time")
                }) {
                    HStack {
                        DatePicker("Date", selection: $dueDate, displayedComponents: .date)
                            .labelsHidden()
                        DatePicker("Time", selection: $dueTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                }

                Section(header: HStack {
                    Image(systemName: "calendar.badge.exclamationmark")
                    Text("Priority")
                }) {
                    Picker("Select priority", selection: $priority) {
                        ForEach(1...5, id: \.self) { level in
                            Text("\(level)").tag(level)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Add New Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let combinedDateTime = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: dueTime), minute: Calendar.current.component(.minute, from: dueTime), second: 0, of: dueDate) ?? dueDate
                        let newTask = d.ToDo(title: taskTitle, dueDate: combinedDateTime, priority: priority)
                        tasks.append(newTask)
                        dismiss()
                    }
                    .disabled(taskTitle.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
