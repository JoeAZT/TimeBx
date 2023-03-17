//
//  Task.swift
//  TimeBox
//
//  Created by Joseph Taylor on 24/02/2023.
//

import SwiftUI
import RealmSwift

class Task: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title = ""
    @Persisted var startTime = Date()
    @Persisted var endTime = Date()
    @Persisted var completed = false
    @Persisted var colorOption = ColorOptions.green
}

extension Task {
    var color: Color {
        colorOption.color
    }
}
