//
//  MatchCell.swift
//  Spielplan
//
//  Created by Bastian Kohlbauer on 07.05.18.
//  Copyright © 2018 Bastian Kohlbauer. All rights reserved.
//

import UIKit

class MatchCell: UITableViewCell {
  
  static let height: CGFloat = 100.0
  static let identifier = "MatchCell"
  
  private var titleLabel: UILabel!
  private var team1Label: UILabel!
  private var team2Label: UILabel!
  private var seperatorLabel: UILabel!
  private var dateLabel: UILabel!
  
  /// Constructs the title fot the cell
  private var title: String? {
    guard let date = match?.date.toLocalDate, let type = match?.type.rawValue else {
      return nil
    }
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.locale = Locale.autoupdatingCurrent
    let dateString = formatter.string(from: date)
    return type + " on " + dateString
  }
  
  /// Returns a time descripton how far away the date is
  private var dateDescription: String? {
    guard let toDate = match?.date.toLocalDate else {
      return nil
    }
    let fromDate = Date().toLocalDate
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .abbreviated
    formatter.zeroFormattingBehavior = .dropAll
    formatter.maximumUnitCount = 2
    formatter.allowedUnits = [.year, .month, .day]
    formatter.includesApproximationPhrase = true
    formatter.includesTimeRemainingPhrase = true
    return formatter.string(from: fromDate, to: toDate)
  }
  
  /// The match the cell should display
  var match: Match? {
    didSet { setupContent() }
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if let titleLabel = titleLabel, let team1Label = team1Label, let team2Label = team2Label, let seperatorLabel = seperatorLabel, let dateLabel = dateLabel {
      let padding: CGFloat = 10.0
      // dateLabel
      let dateLabelHeight: CGFloat = 15.0
      dateLabel.frame = CGRect(x: padding, y: bounds.height - dateLabelHeight - padding, width: bounds.width - (2 * padding), height: dateLabelHeight)
      // titleLabel
      let titleLabelheight = (dateLabel.frame.minY - (3 * padding))/2.0
      titleLabel.frame = CGRect(x: padding, y: padding, width: bounds.width - (2 * padding), height: titleLabelheight)
      // seperatorLabel
      let speratorWidth: CGFloat = 10.0
      seperatorLabel.frame = CGRect(x: (bounds.width - speratorWidth)/2.0, y: titleLabel.frame.maxY + padding, width: speratorWidth, height: titleLabelheight)
      // team1Label
      team1Label.frame = CGRect(x: padding, y: seperatorLabel.frame.minY, width: seperatorLabel.frame.minX - (2 * padding), height: titleLabelheight)
      // team2Label
      team2Label.frame = CGRect(x: seperatorLabel.frame.maxX + padding, y: seperatorLabel.frame.minY, width: team1Label.bounds.width, height: titleLabelheight)
    }
  }
  
  /// Constructs view objects
  private func setupView() {
    if titleLabel == nil {
      titleLabel = UILabel(frame: .zero)
      titleLabel.font = UIFont.systemFont(ofSize: 16)
      titleLabel.textAlignment = .center
      titleLabel.adjustsFontSizeToFitWidth = true
      titleLabel.numberOfLines = 1
      titleLabel.textColor = .darkGray
      addSubview(titleLabel)
    }
    if team1Label == nil {
      team1Label = UILabel(frame: .zero)
      team1Label.textAlignment = .right
      team1Label.adjustsFontSizeToFitWidth = true
      team1Label.numberOfLines = 1
      team1Label.textColor = .black
      addSubview(team1Label)
    }
    if team2Label == nil {
      team2Label = UILabel(frame: .zero)
      team2Label.textAlignment = .left
      team2Label.adjustsFontSizeToFitWidth = true
      team2Label.numberOfLines = 1
      team2Label.textColor = .black
      addSubview(team2Label)
    }
    if seperatorLabel == nil {
      seperatorLabel = UILabel(frame: .zero)
      seperatorLabel.font = UIFont.systemFont(ofSize: 16)
      seperatorLabel.textAlignment = .center
      seperatorLabel.adjustsFontSizeToFitWidth = true
      seperatorLabel.numberOfLines = 1
      seperatorLabel.textColor = .black
      seperatorLabel.text = ":"
      addSubview(seperatorLabel)
    }
    if dateLabel == nil {
      dateLabel = UILabel(frame: .zero)
      dateLabel.font = UIFont.systemFont(ofSize: 14)
      dateLabel.textAlignment = .center
      dateLabel.adjustsFontSizeToFitWidth = true
      dateLabel.numberOfLines = 1
      dateLabel.textColor = .lightGray
      addSubview(dateLabel)
    }
  }
  
  /// Setup up content from match data
  private func setupContent() {
    titleLabel.text = title
    team1Label.text = match?.team1.name ?? "-"
    team2Label.text = match?.team2.name ?? "-"
    dateLabel.text = dateDescription
    let standardFont = UIFont.systemFont(ofSize: 18)
    let boldFont = UIFont.boldSystemFont(ofSize: 18)
    if let type = match?.type {
      switch type {
      case .homeGame:
        team1Label.font = boldFont
        team2Label.font = standardFont
      case .awayGame:
        team1Label.font = standardFont
        team2Label.font = boldFont
      }
    } else {
      team1Label.font = standardFont
      team2Label.font = standardFont
    }
  }
}
