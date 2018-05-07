//
//  Date.swift
//  Spielplan
//
//  Created by Bastian Kohlbauer on 07.05.18.
//  Copyright © 2018 Bastian Kohlbauer. All rights reserved.
//

import Foundation

extension Date {
  
  /// Converts date to local date
  var toLocalDate: Date {
    let interval = NSTimeZone.local.secondsFromGMT()
    return addingTimeInterval(TimeInterval(interval))
  }
}
