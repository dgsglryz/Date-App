//
//  Date.swift
//  DogusGuleryuz
//
//  Created by Dogus Guleryuz on 10.03.2023.
//

import Foundation

enum DateFormat {
  case standard, two, long
}

struct Date: Comparable {
  
  private(set) var month: Int
  private(set) var day: Int
  private(set) var year: Int
  private(set) var dateFormat: DateFormat = .standard
  
  init(month: Int = 1, day: Int = 1, year: Int = 2000) {
    self.month = month
    self.day = day
    self.year = year
  }
  
  mutating func input() {
    print("Enter a date (in the format of month/day/year):")
    if let input = readLine() {
      let components = input.components(separatedBy: "/")
      guard components.count == 3 else {
        print("Invalid date format. Try again.")
        self.input()
        return
      }
      guard let month = Int(components[0]), let day = Int(components[1]), let year = Int(components[2]) else {
        print("Invalid date format. Try again.")
        self.input()
        return
      }
      if !isValidDate(month: month, day: day, year: year) {
        print("Invalid date. Try again.")
        self.input()
        return
      }
      self.month = month
      self.day = day
      self.year = year
    } else {
      print("Invalid input. Try again.")
      self.input()
    }
  }
  
  func show() {
    switch dateFormat {
    case .standard:
      print("\(month)/\(day)/\(year)")
    case .two:
      let monthStr = String(format: "%02d", month)
      let dayStr = String(format: "%02d", day)
      let yearStr = String(format: "%02d", year)
      print("\(monthStr)/\(dayStr)/\(yearStr)")
    case .long:
      let monthStr = getMonthName()
      print("\(monthStr) \(day), \(year)")
    }
  }
  
  mutating func set(month: Int, day: Int, year: Int) -> Bool {
    if isValidDate(month: month, day: day, year: year) {
      self.month = month
      self.day = day
      self.year = year
      return true
    } else {
      return false
    }
  }
  
  mutating func setFormat(_ newFormat: DateFormat) {
      self.dateFormat = newFormat
    }
  
  private func isValidDate(month: Int, day: Int, year: Int) -> Bool {
    if year < 0 {
      return false
    }
    if month < 1 || month > 12 {
      return false
    }
    let daysInMonth = getDaysInMonth(month: month)
    if day < 1 || day > daysInMonth {
      return false
    }
    return true
  }
  
  private func getDaysInMonth(month: Int) -> Int {
    switch month {
    case 2:
      return 28
    case 4, 6, 9, 11:
      return 30
    default:
      return 31
    }
  }
  
  private func getMonthName() -> String {
    switch month {
    case 1:
      return "January"
    case 2:
      return "February"
    case 3:
      return "March"
    case 4:
      return "April"
    case 5:
      return "May"
    case 6:
      return "June"
    case 7:
      return "July"
    case 8:
      return "August"
    case 9:
      return "September"
    case 10:
      return "October"
    case 11:
      return "November"
    case 12:
      return "December"
    default:
      return ""
    }
  }
  
  mutating func increment(_ numDays: Int = 1) {
    var daysLeft = numDays
    while daysLeft > 0 {
      let daysInMonth = getDaysInMonth(month: month)
      if day + daysLeft <= daysInMonth {
        day += daysLeft
        daysLeft = 0
      } else {
        daysLeft -= (daysInMonth - day + 1)
        day = 1
        if month == 12 {
          month = 1
          year += 1
        } else {
          month += 1
        }
      }
    }
  }
  
  static func <(lhs: Date, rhs: Date) -> Bool {
    if lhs.year != rhs.year {
      return lhs.year < rhs.year
    } else if lhs.month != rhs.month {
      return lhs.month < rhs.month
    } else {
      return lhs.day < rhs.day
    }
  }
  
  static func ==(lhs: Date, rhs: Date) -> Bool {
    return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
  }
}

