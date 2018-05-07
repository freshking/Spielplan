//
//  LeagueInfoView.swift
//  Spielplan
//
//  Created by Bastian Kohlbauer on 07.05.18.
//  Copyright © 2018 Bastian Kohlbauer. All rights reserved.
//

import UIKit

class LeagueInfoView: UIView {
  
  private var titleLabel: UILabel!
  private var dateLabel: UILabel!
  private var bottomLine: CAShapeLayer!
  
  /// The leage the view should display
  var league: League? {
    didSet { setupContent() }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
    translatesAutoresizingMaskIntoConstraints = true
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if let bottomLine = bottomLine {
      let path = UIBezierPath()
      path.move(to: CGPoint(x: 0.0, y: bounds.height - bottomLine.lineWidth))
      path.addLine(to: CGPoint(x: bounds.width, y: bounds.height - bottomLine.lineWidth))
      bottomLine.path = path.cgPath
    }
  }
  
  /// Constructs view objects
  private func setupView() {
    let padding: CGFloat = 10.0
    if bottomLine == nil {
      bottomLine = CAShapeLayer()
      bottomLine.lineWidth = 1.0
      bottomLine.strokeColor = UIColor.darkGray.cgColor
      layer.addSublayer(bottomLine)
    }
    if titleLabel == nil {
      let height: CGFloat = 30.0
      titleLabel = UILabel(frame: CGRect(x: padding, y: (bounds.height - height)/2.0, width: bounds.width - (2 * padding), height: height))
      titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
      titleLabel.textAlignment = .center
      titleLabel.adjustsFontSizeToFitWidth = true
      titleLabel.numberOfLines = 1
      titleLabel.textColor = .black
      titleLabel.autoresizingMask = .flexibleWidth
      addSubview(titleLabel)
    }
    if dateLabel == nil {
      dateLabel = UILabel(frame: CGRect(x: padding, y: titleLabel.frame.maxY + padding, width: bounds.width - (2 * padding), height: 18.0))
      dateLabel.font = UIFont.systemFont(ofSize: 14)
      dateLabel.textAlignment = .center
      dateLabel.adjustsFontSizeToFitWidth = true
      dateLabel.numberOfLines = 1
      dateLabel.textColor = .darkGray
      dateLabel.autoresizingMask = .flexibleWidth
      addSubview(dateLabel)
    }
  }
  
  /// Setup up content from league data
  private func setupContent() {
    // titleLabel
    titleLabel.text = league?.name
    // dateLabel
    if let start = league?.start?.toLocalDate, let end = league?.end?.toLocalDate {
      let formatter = DateFormatter()
      formatter.dateStyle = .short
      formatter.locale = Locale.autoupdatingCurrent
      dateLabel.text = "Game Plan from" + " \(formatter.string(from: start)) " + "to" + " \(formatter.string(from: end))"
    } else {
      dateLabel.text = "Game Plan"
    }
  }
}
