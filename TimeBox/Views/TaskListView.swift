//
//  TaskListView.swift
//  TimeBox
//
//  Created by Joseph Taylor on 24/02/2023.
//

import SwiftUI
import RealmSwift

struct TaskListView: View {
    @State private var addTaskViewPresented = false
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedResults(
        Task.self,
        where: { $0.completed == false }
    ) var incompleteTasks
    
    @ObservedResults(
        Task.self,
        where: { $0.completed == true }
    ) var completedTasks
    
    //Add Button
    @ViewBuilder var newTaskButton: some View {
        Button(action: openNewTask) {
            HStack {
                Spacer()
                Text("+")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .padding(8)
                Spacer()
            }
            .background(colorScheme == .dark ? .white : .black)
            .cornerRadius(15)
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
        }
        .sheet(isPresented: $addTaskViewPresented) {
            AddTaskView(taskObject: Task())
                .presentationDetents([.fraction(0.32)])
        }
    }
    
    var body: some View {
        VStack {
            List {
                Section("Running Tasks") {
                    if incompleteTasks.isEmpty {
                        Text(completedTasks.isEmpty ? "Your day is looking a little empty :(" : "All tasks complete :)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    ForEach(incompleteTasks) { task in
                        TaskRowView(taskObject: task)
                    }
                    .onDelete(perform: $incompleteTasks.remove)
                }
                Section {
                    if completedTasks.isEmpty {
                        Text("Completed tasks will land here.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    ForEach(completedTasks) { task in
                        TaskRowView(taskObject: task)
                    }
                    .onDelete(perform: $completedTasks.remove)
                } header: {
                    Text("Complete")
                }
            }
            . listRowSeparator(. hidden)
            newTaskButton
        }
        
        //Button Title
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Image(colorScheme == .dark ? "darklogo" : "logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            }
            
            //Notification button
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    allowNotifications()
                                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                }label:{
                    Image(systemName: "bell.fill")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Actions
extension TaskListView {
    func openNewTask() {
        addTaskViewPresented.toggle()
    }
    
    func allowNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("big boy alert")
                } else if error != nil {
                    print("error")
                }
            }
    }
    
    func deleteAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
