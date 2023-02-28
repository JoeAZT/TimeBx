//
//  AddTaskView.swift
//  TimeBox
//
//  Created by Joseph Taylor on 24/02/2023.
//

import SwiftUI
import RealmSwift

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.realm) var realm
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedRealmObject var taskObject: Task
    
    var isUpdating: Bool {
        taskObject.realm != nil
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter Task here", text: $taskObject.title)
                    .padding(10)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(10)
                
                VStack {
                    DatePicker("Start", selection: $taskObject.startTime, displayedComponents: .hourAndMinute)
                    
                    DatePicker("End", selection: $taskObject.endTime, displayedComponents: .hourAndMinute)
                }
                .padding(.leading, 10)
                
                Button {
                    save()
                } label: {
                    Text("Save")
                        .bold()
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                        .padding()
                        .background(colorScheme == .dark ? .white : .black)
                        .cornerRadius(10)
                }
                .disabled(taskObject.title.isEmpty)
                
                
                .navigationTitle("Add new task")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "multiply")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .onAppear {
                UIDatePicker.appearance().minuteInterval = 5
            }
        }
    }
}

// MARK: - Actions
extension AddTaskView {
    func save() {
        try? realm.write {
            realm.add(taskObject)
        }
        dismiss()
    }
}

//extension AddTaskView {
//  func sort() {
//    var sortedTasks: Results<Task> {
//      guard realm != nil,
//        let thawed = thaw(),
//          !thawed.isInvalidated
//      else {
//        return nil
//        }
//      return thawed.incompleteTasks.sorted(by: \.startTime, ascending: true)
//    }
//  }
//}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(taskObject: Task())
        AddTaskView(taskObject: TaskMock.task2)
    }
}
