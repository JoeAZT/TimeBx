//
//  AddTaskView.swift
//  TimeBox
//
//  Created by Joseph Taylor on 24/02/2023.
//

import SwiftUI
import RealmSwift
import UserNotifications

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
                    saveToRealm()
                    setNotifications(task: taskObject)
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
                UIDatePicker.appearance().minuteInterval = 15
            }
        }
    }
}

// MARK: - Actions
extension AddTaskView {
    func saveToRealm() {
        try? realm.write {
            realm.add(taskObject)
        }
        dismiss()
    }
    
    func setNotifications(task: Task) {
        let content = UNMutableNotificationContent()
        content.title = "TimeBx"
        content.subtitle = "\(task.title) - \(DateString().dateFormat(date: taskObject.startTime))"
        content.sound = UNNotificationSound.default
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: task.startTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        UNUserNotificationCenter.current().add(.init(identifier: UUID().uuidString, content: content, trigger: trigger))
    }
}

//let dateArray = realm.objects(Task.self)
//let sorted = dateArray.sorted(by: { $0.startTime.compare($1.startTime) == .orderedDescending })
//realm.deleteAll()
//try? realm.write {
//    for tasks in sorted {
//        realm.add(tasks)
//    }
//}
//print(sorted)

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
