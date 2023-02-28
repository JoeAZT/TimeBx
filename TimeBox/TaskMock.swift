//
//  TaskMock.swift
//  TimeBox
//
//  Created by Joseph Taylor on 24/02/2023.
//

import Foundation

enum TaskMock {
  static var task1: Task {
    let task = Task()
    task.title = "Meeting"
    task.startTime = Date()
    task.endTime = Date().addingTimeInterval(6000)
    task.completed = false
    return task
  }

  static var task2: Task {
    let task = Task()
    task.title = "1-2-1"
    task.startTime = Date()
    task.endTime = Date().addingTimeInterval(6000)
    task.completed = false
    return task
  }
  
  static var task3: Task {
    let task = Task()
    task.title = "Quick sync"
    task.startTime = Date()
    task.endTime = Date().addingTimeInterval(6000)
    task.completed = false
    return task
  }
  
  static var task4: Task {
    let task = Task()
    task.title = "Stand up"
    task.startTime = Date()
    task.endTime = Date().addingTimeInterval(6000)
    task.completed = false
    return task
  }
  
  static var task5: Task {
    let task = Task()
    task.title = "Focussed coding"
    task.startTime = Date()
    task.endTime = Date().addingTimeInterval(6000)
    task.completed = false
    return task
  }
  
  static var task6: Task {
    let task = Task()
    task.title = "Huddle"
    task.startTime = Date()
    task.endTime = Date().addingTimeInterval(6000)
    task.completed = false
    return task
  }
}
