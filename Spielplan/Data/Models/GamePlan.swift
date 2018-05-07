//
//  GamePlan.swift
//  Spielplan
//
//  Created by Bastian Kohlbauer on 07.05.18.
//  Copyright © 2018 Bastian Kohlbauer. All rights reserved.
//

import Foundation

/// GamePlan
struct GamePlan {
  
  let league: League
  var firstRoundMatches = [Match]()
  var secondRoundMatches = [Match]()
  
  /// Initialized the object with from league to create its game plan
  ///
  /// - Parameter league: League object
  init(league: League) {
    self.league = league
    // matches with only one team or less cant happen
    let teams = league.teams
    guard teams.count > 1 else {
      return
    }
    // esure start and end dates exist
    guard let start = league.start, let end = league.end else {
      return
    }
    // get all sundays
    var sundays = [Date]()
    var components = DateComponents()
    components.weekday = 1 // sunday
    let calendar = Calendar.current
    calendar.enumerateDates(startingAfter: start, matching: components, matchingPolicy: Calendar.MatchingPolicy.strict) { (date, isExactMatch, shouldStop) in
      guard let date = date, isExactMatch else {
        return
      }
      if calendar.compare(end, to: date, toGranularity: Calendar.Component.day) == .orderedAscending {
        shouldStop = true
      } else {
        sundays.append(date)
      }
    }
    // first round matches
    for match in constructMatches(dates: sundays, teams: teams, type: .homeGame) {
      firstRoundMatches.append(match)
    }
    // second round matches
    for match in constructMatches(dates: sundays, teams: teams.reversed(), type: .awayGame) {
      secondRoundMatches.append(match)
    }
  }
  
  /// Constructs matches between different teams
  ///
  /// - Parameters:
  ///   - dates: Dates for which the matches should be applied to
  ///   - teams: List of teams that should play against each other
  ///   - type: Type of game
  /// - Returns: Array of constructed matches between the teams
  private func constructMatches(dates: [Date], teams: [Team], type: MatchType) -> [Match] {
    var matches = [Match]()
    var dateIndex: Int = 0
    for (i, homeTeam) in teams.enumerated() {
      for (j, awayTeam) in teams.enumerated() {
        if i != j {
          guard dateIndex < dates.count else {
            continue
          }
          let date = dates[dateIndex]
          let match = Match(date: date, team1: homeTeam, team2: awayTeam, type: type)
          matches.append(match)
          dateIndex += 1
        }
      }
    }
    return matches
  }
}
