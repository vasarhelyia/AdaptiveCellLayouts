//
//  ViewController.swift
//  TableRotationTest
//
//
//  Created by Agnes Vasarhelyi on 9/12/18.
//  Copyright © 2018 Agnes Vasarhelyi. All rights reserved.
//
import Foundation
import UIKit

final class CustomCell: UITableViewCell {
  @IBOutlet weak var numberLabel: UILabel!
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var detailLabel: UILabel!

  static let reuseIdentifier = "CustomCell"

  override func awakeFromNib() {
    let rand: UInt32 = arc4random() % 100

    // Number
    self.numberLabel.text = "\(rand)"

    // Status
    let emoji: String = rand < 50 ? (rand < 25 ? "🥶" : "🤬") : (rand > 75 ? "😎" : "🤩")
    self.detailLabel.text = emoji
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)

    if self.traitCollection.horizontalSizeClass == .compact &&
      self.traitCollection.verticalSizeClass == .regular {
      // iPhone portait (RxC)
      self.detailLabel.textAlignment = .left
    } else {
      // iPad (RxR), iPhone landscape (CxC)
      self.detailLabel.textAlignment = .right
    }
  }

}
