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
    let padding: CGFloat = 10.0
    let top = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    if let titleLabel = titleLabel, let dateLabel = dateLabel {
      // titleLabel
      titleLabel.frame = CGRect(x: padding, y: top + padding, width: bounds.width - (2 * padding), height: 30.0)
      // dateLabel
      dateLabel.frame = CGRect(x: padding, y: titleLabel.frame.maxY + padding, width: bounds.width - (2 * padding), height: 25.0)
    }
  }
  
  /// Constructs view objects
  private func setupView() {
    if bottomLine == nil {
      bottomLine = CAShapeLayer()
      bottomLine.lineWidth = 1.0
      bottomLine.strokeColor = UIColor.darkGray.cgColor
      layer.addSublayer(bottomLine)
    }
    if titleLabel == nil {
      titleLabel = UILabel(frame: .zero)
      titleLabel.font = UIFont.systemFont(ofSize: 20)
      titleLabel.textAlignment = .center
      titleLabel.adjustsFontSizeToFitWidth = true
      titleLabel.numberOfLines = 1
      titleLabel.textColor = .black
      addSubview(titleLabel)
    }
    if dateLabel == nil {
      dateLabel = UILabel(frame: .zero)
      dateLabel.font = UIFont.systemFont(ofSize: 16)
      dateLabel.textAlignment = .center
      dateLabel.adjustsFontSizeToFitWidth = true
      dateLabel.numberOfLines = 1
      dateLabel.textColor = .darkGray
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
