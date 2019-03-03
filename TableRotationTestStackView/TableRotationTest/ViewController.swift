//
//  ViewController.swift
//  TableRotationTest
//
//  Created by Agnes Vasarhelyi on 10/31/18.
//  Copyright © 2018 Agnes Vasarhelyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  private var tableView = UITableView()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = 44
    self.view.addSubview(tableView)

    self.tableView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
      self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
      self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
    ])

    self.tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.reuseIdentifier)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let reuseIdentifier = "CustomCell"
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? CustomCell ??
      CustomCell(style: .default, reuseIdentifier: reuseIdentifier)
    return cell
  }

}

