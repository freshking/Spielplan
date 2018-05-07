//
//  ContentProducer.swift
//  Spielplan
//
//  Created by Bastian Kohlbauer on 07.05.18.
//  Copyright © 2018 Bastian Kohlbauer. All rights reserved.
//

import Foundation

class ContentProducer {
  
  /// Extracts content from source file
  ///
  /// - Returns: File contents
  static func fileContent(name: String, type: String = "json") -> Any? {
    if let path = Bundle.main.path(forResource: name, ofType: type) {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        do {
          let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .allowFragments])
          return json as? Dictionary<String, Any>
        } catch let error {
          print(error.localizedDescription)
        }
      } catch let error {
        print(error.localizedDescription)
      }
    } else {
      print("invalid resource")
    }
    return nil
  }
}
