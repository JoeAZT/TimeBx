//
//  DateString.swift
//  TimeBox
//
//  Created by Joseph Taylor on 24/02/2023.
//

import Foundation

struct DateString {
  func dateFormat(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter.string(from: date)
  }
    
//    func whatNumberIsThisFfs(index: Int) {
//
//    }
}
