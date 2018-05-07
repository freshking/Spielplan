//
//  Team.swift
//  Spielplan
//
//  Created by Bastian Kohlbauer on 07.05.18.
//  Copyright © 2018 Bastian Kohlbauer. All rights reserved.
//

import Foundation

/// Team
struct Team: Equatable {
  var name: String?
  static func ==(lhs: Team, rhs: Team) -> Bool {
    return lhs.name == rhs.name
  }
}
