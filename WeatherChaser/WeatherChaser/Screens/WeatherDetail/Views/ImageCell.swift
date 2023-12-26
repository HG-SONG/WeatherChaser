//
//  TestCollectionViewCell2.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/26.
//

import UIKit

class ImageCell: UICollectionViewCell {
    static let identifier = "ImageCell"
    private var textStackView = UIStackView(frame: .zero)
    private var titleLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.contentView.backgroundColor = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTitleLabel()
        layoutTextStackView()
    }
    
    
    private func layoutTextStackView() {
        if !self.contentView.subviews.contains(textStackView) {
            self.contentView.addSubview(textStackView)
        }
        
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                textStackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                textStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                textStackView.widthAnchor.constraint(lessThanOrEqualTo: self.contentView.widthAnchor),
                textStackView.heightAnchor.constraint(lessThanOrEqualTo: self.contentView.heightAnchor)
                
            ]
        )
    }
    private func layoutTitleLabel() {
        if !self.contentView.subviews.contains(titleLabel) {
            self.contentView.addSubview(titleLabel)
        }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 10.0),
                titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5.0)
                
            ]
        )
    }
}
