//
//  TaskRow.swift
//  TimeBox
//
//  Created by Joseph Taylor on 24/02/2023.
//

import SwiftUI
import RealmSwift

struct TaskRowView: View {
    @State private var addTaskViewPresented = false
    @Environment(\.colorScheme) var colorScheme
    @ObservedRealmObject var taskObject: Task
    
    var buttonImage: String {
        taskObject.completed ? "circle.inset.filled" : "circle"
    }
    
    var body: some View {
            Button(action: toggleCompleted) {
                HStack {
                    HStack {
                        Text("\(taskObject.title)")
                            .bold()
                        Spacer()
                        Text(DateString().dateFormat(date: taskObject.startTime))
                        Text("-")
                        Text(DateString().dateFormat(date: taskObject.endTime))
                    }
                    .opacity(taskObject.completed == true ? 0.6 : 1)
                    Image(systemName: buttonImage)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(colorScheme == .dark ? .white : .black, lineWidth: 4)
                )
            }
            .buttonStyle(.plain)
        }
}

// MARK: - Actions
extension TaskRowView {
    
    func toggleCompleted() {
        $taskObject.completed.wrappedValue.toggle()
    }
}

struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskRowView(taskObject: TaskMock.task1)
            TaskRowView(taskObject: TaskMock.task2)
        }
        .previewLayout(.sizeThatFits)
    }
}
