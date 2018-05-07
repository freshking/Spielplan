//
//  League.swift
//  Spielplan
//
//  Created by Bastian Kohlbauer on 07.05.18.
//  Copyright © 2018 Bastian Kohlbauer. All rights reserved.
//

import Foundation

/// League
struct League {
  
  var name: String?
  var season: String?
  var start: Date?
  var end: Date?
  var teams = [Team]()
  
  /// Initializes the object with from the content dictionary
  ///
  /// - Parameter json: Content dictionary
  init(json: Dictionary<String, Any>) {
    name = json["league"] as? String
    season = json["season"] as? String
    if let dateString = json["start"] as? String {
      start = DateTransformers.date(string: dateString)
    }
    if let dateString = json["end"] as? String {
      end = DateTransformers.date(string: dateString)
    }
    if let rawTeams = json["teams"] as? [[String: String]] {
      for team in rawTeams {
        if let name = team["name"] {
          teams.append(Team(name: name))
        }
      }
    }
  }
}
