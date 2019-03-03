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
  private var numberLabel = UILabel()
  private var titleLabel = UILabel()
  private var detailLabel = UILabel()

  // iPad portrait, landscape (RxR), iPhone landscape (CxC)
  private var regularRegularConstraints: [NSLayoutConstraint] = []
  // iPhone portrait (RxC)
  private var regularCompactConstraints: [NSLayoutConstraint] = []

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setup()
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)

    if self.traitCollection.horizontalSizeClass == .compact &&
      self.traitCollection.verticalSizeClass == .regular {
      // iPhone portait (RxC)
      self.detailLabel.textColor = UIColor.lightGray
      self.detailLabel.textAlignment = .left
    } else {
      // iPad (RxR), iPhone landscape (CxC)
      self.detailLabel.textColor = UIColor.darkGray
      self.detailLabel.textAlignment = .right
    }

    self.updateLayout()
  }

  private func setup() {
    // Number
    self.numberLabel.font = UIFont.boldSystemFont(ofSize: 15)
    self.numberLabel.textAlignment = .center
    self.numberLabel.text = "\(arc4random() % 100)"
    self.numberLabel.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(self.numberLabel)

    // Title
    self.titleLabel.font = UIFont.systemFont(ofSize: 17)
    self.titleLabel.text = "Mood"
    self.titleLabel.textColor = UIColor.darkGray
    self.titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    self.titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(self.titleLabel)

    // Status
    self.detailLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
    let rand = arc4random() % 100
    self.detailLabel.text = rand < 50 ? (rand < 25 ? "🤩" : "😎") : (rand > 75 ? "🥶" : "🤬")
    self.detailLabel.textAlignment = .left
    self.detailLabel.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(self.detailLabel)

    // Layout

    NSLayoutConstraint.activate([
      self.numberLabel.widthAnchor.constraint(equalToConstant: 70),
      self.numberLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
      self.numberLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      self.numberLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
      self.titleLabel.leadingAnchor.constraint(equalTo: self.numberLabel.trailingAnchor, constant: 16),
      self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
      self.detailLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
    ])

    self.regularCompactConstraints = [
      self.detailLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 6),
      self.detailLabel.leadingAnchor.constraint(equalTo: self.numberLabel.trailingAnchor, constant: 16),
      self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
      self.detailLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
    ]

    self.regularRegularConstraints = [
      self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
      self.titleLabel.trailingAnchor.constraint(equalTo: self.detailLabel.leadingAnchor, constant: -16),
      self.detailLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
    ]

    self.updateLayout()
  }

  // Activates and deactives constraints based on size classes
  private func updateLayout() {
    switch self.traitCollection.horizontalSizeClass {
    case .regular:
      // iPad
      NSLayoutConstraint.deactivate(self.regularCompactConstraints)
      NSLayoutConstraint.activate(self.regularRegularConstraints)
    case .compact:
      switch self.traitCollection.verticalSizeClass {
      case .regular:
        // iPhone portait
        NSLayoutConstraint.deactivate(self.regularRegularConstraints)
        NSLayoutConstraint.activate(self.regularCompactConstraints)
      case .compact:
        // iPhone landscape
        NSLayoutConstraint.deactivate(self.regularCompactConstraints)
        NSLayoutConstraint.activate(self.regularRegularConstraints)
      default: break
      }
    default: break
    }
  }

}
