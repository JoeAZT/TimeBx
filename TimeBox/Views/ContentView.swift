//
//  ContentView.swift
//  TimeBox
//
//  Created by Joseph Taylor on 24/02/2023.
//

import SwiftUI

//Create a widget for the tasks so you can see what the current task is and time remaining?

struct ContentView: View {
  var body: some View {
    NavigationView {
      TaskListView()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
