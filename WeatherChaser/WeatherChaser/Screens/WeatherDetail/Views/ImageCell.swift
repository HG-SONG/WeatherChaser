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
    private let titleLabel = UILabel(frame: .zero)
    
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
    
    func setImageView(viewModel : [String]) {
        let title = viewModel[0]
        
        let imageName = viewModel[1]
        
        setTitleLabel(text: title)
        setBackgroundView(imageName: imageName)
        setTextStackView(viewModel)
        
    }
    
    private func setBackgroundView(imageName :String) {
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        self.backgroundView = imageView
        self.backgroundView?.layer.cornerRadius = 15.0
    }
    
    private func setTitleLabel(text:String) {
        self.titleLabel.text = text
        self.titleLabel.font = UIFont.systemFont(ofSize: 20.0)
    }
    
    private func setTextStackView(_ array : [String]) {
        self.textStackView.removeFromSuperview()
        
        let tmpStackView = UIStackView()
        tmpStackView.axis = .vertical
        tmpStackView.alignment = .center
        let startIndex = 2
        let items = array[startIndex...]
        
        for item in items {
            let label = UILabel(frame: .zero)
            label.text = item
            label.numberOfLines = 2
            label.font = UIFont.systemFont(ofSize: 25.0, weight: .bold)
            tmpStackView.addArrangedSubview(label)
        }
        self.textStackView = tmpStackView
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
