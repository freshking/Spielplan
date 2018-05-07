//
//  ViewController.swift
//  Spielplan
//
//  Created by Bastian Kohlbauer on 07.05.18.
//  Copyright © 2018 Bastian Kohlbauer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  private var headerView: LeagueInfoView!
  private var tableView: UITableView!
  private var gamePlan: GamePlan?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupData()
  }
  
  /// Setup any additional views contents
  private func setupView() {
    if headerView == nil {
      headerView = LeagueInfoView(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: 160.0))
      view.addSubview(headerView)
    }
    if tableView == nil {
      let y = headerView.frame.maxY
      tableView = UITableView(frame: CGRect(x: 0.0, y: y, width: view.bounds.width, height: view.bounds.height - y))
      tableView.delegate = self
      tableView.dataSource = self
      tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      tableView.register(MatchCell.self, forCellReuseIdentifier: MatchCell.identifier)
      view.addSubview(tableView)
    }
  }
  
  /// The match the cell should display
  private func setupData() {
    guard let json = ContentProducer.fileContent(name: "mannschaften") as? Dictionary<String, Any> else {
      return
    }
    let league = League(json: json)
    headerView.league = league
    gamePlan = GamePlan(league: league)
  }
}

//MARK:- UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return gamePlan?.firstRoundMatches.count ?? 0
    case 1:
      return gamePlan?.secondRoundMatches.count ?? 0
    default:
      return 0
    }
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return MatchCell.height
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MatchCell.identifier, for: indexPath) as! MatchCell
    switch indexPath.section {
    case 0:
      cell.match = gamePlan?.firstRoundMatches[indexPath.row]
    case 1:
      cell.match = gamePlan?.secondRoundMatches[indexPath.row]
    default:
      break
    }
    return cell
  }
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40.0
  }
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let height = self.tableView(tableView, heightForHeaderInSection: section)
    let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: height))
    label.backgroundColor = UIColor(hexString: "D6D6D6")
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textAlignment = .center
    label.adjustsFontSizeToFitWidth = true
    label.numberOfLines = 1
    label.textColor = .black
    switch section {
    case 0:
      label.text = "First Round Matches"
    case 1:
      label.text = "Second Round Matches"
    default:
      break
    }
    return label
  }
}
