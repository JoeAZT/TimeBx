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
    
    @ViewBuilder var newTaskButton: some View {
        Button(action: openNewTask) {
            Text("+")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .padding(.horizontal, 10)
                .padding(.bottom, 5)
                .background(colorScheme == .dark ? .white : .black)
                .cornerRadius(10)
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
        .toolbar {
            ToolbarItem(placement: .principal)  {
                Image(colorScheme == .dark ? "LogoDarkMode" : "LogoStandardMode")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
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
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
