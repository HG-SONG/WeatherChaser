//
//  TestCollectionViewCell.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/21.
//

import UIKit

class LabelCell: UICollectionViewCell {
    static let identifier = "LabelCell"
    private var titleLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.contentView.backgroundColor = .black
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTitleLabel()
    }
    
    func setTitleLabel(text:String) {
        if Int(text) != nil {
            self.titleLabel.text = text.makeUnitSymbol()
        } else {
            self.titleLabel.text = text
        }

        self.titleLabel.font = UIFont.systemFont(ofSize: 30.0, weight: .bold)
        self.titleLabel.numberOfLines = 3
    }
    
    private func layoutTitleLabel() {
        if !self.contentView.subviews.contains(titleLabel) {
            self.contentView.addSubview(titleLabel)
        }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                titleLabel.widthAnchor.constraint(lessThanOrEqualTo: self.contentView.widthAnchor),
                titleLabel.heightAnchor.constraint(lessThanOrEqualTo: self.contentView.heightAnchor)
                
            ]
        )
    }
}
