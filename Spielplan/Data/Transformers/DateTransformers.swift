//
//  DateTransformers.swift
//  Spielplan
//
//  Created by Bastian Kohlbauer on 07.05.18.
//  Copyright © 2018 Bastian Kohlbauer. All rights reserved.
//

import Foundation

class DateTransformers {
  
  /// Transforms date string to Date
  ///
  /// - Parameters:
  ///   - string: Date string
  ///   - format: Date format string
  /// - Returns: Date
  static func  date(string: String, format: String = "yyyy-MM-dd") -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = TimeZone.autoupdatingCurrent
    dateFormatter.locale = Locale.autoupdatingCurrent
    return dateFormatter.date(from: string)
  }
}
