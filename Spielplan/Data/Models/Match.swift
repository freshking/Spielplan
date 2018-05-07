//
//  Match.swift
//  Spielplan
//
//  Created by Bastian Kohlbauer on 07.05.18.
//  Copyright © 2018 Bastian Kohlbauer. All rights reserved.
//

import Foundation

/// Match
struct Match: Equatable {
  var date: Date
  var team1: Team
  var team2: Team
  var type: MatchType
  static func ==(lhs: Match, rhs: Match) -> Bool {
    return lhs.team1 == rhs.team1 && lhs.team2 == rhs.team2 && lhs.type == rhs.type
  }
}

/// MatchType
enum MatchType: String {
  case homeGame = "Home Game"
  case awayGame = "Away Game"
}
