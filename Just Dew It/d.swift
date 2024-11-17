//
//  d.swift
//  Just Dew It
//
//  Created by J.D Aviles on 11/16/24.
//

import Foundation

struct d {
    struct ToDo: Identifiable {
        let id = UUID()
        var title: String
        var dueDate: Date
        var priority: Int

        var formattedDueDate: String {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: dueDate)
        }
    }
}
