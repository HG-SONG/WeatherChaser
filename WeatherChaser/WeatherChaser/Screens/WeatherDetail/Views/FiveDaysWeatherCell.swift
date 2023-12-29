//
//  FiveDaysWeatherCell.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/28.
//

import UIKit

class FiveDaysWeatherCell: UICollectionViewCell {
    static let identifier = "FiveDaysWeatherCell"
    private let titleLabel = UILabel(frame: .zero)
    private let fiveDaysStackView = UIStackView(frame: .zero)
    private let scrollView = UIScrollView(frame: .zero)
    
    func commonInit() {
        self.titleLabel.text = "Weather forecast for 5 days"
        self.titleLabel.font = UIFont.systemFont(ofSize: 25.0,weight: .bold)
        self.fiveDaysStackView.axis = .horizontal
        self.fiveDaysStackView.spacing = 10.0
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    func setFiveDaysWeatherCell(_ viewModel : [Any]) {
        guard let fiveDaysWeathers = viewModel as? [WeatherBy3hViewModel] else {
            return
        }
        
        for item in fiveDaysWeathers {
            let smallStackView = WeatherBy3hView()
            smallStackView.commonInit(viewModel: item)
            self.fiveDaysStackView.addArrangedSubview(smallStackView)
        }
        let totalWidth = fiveDaysStackView.arrangedSubviews.reduce(0) { $0 + $1.frame.width }
        self.scrollView.contentSize = CGSize(width: totalWidth, height: self.scrollView.frame.height)
    }
    
    private func setLayout() {
        setTitleLabelLayout()
        setScrollViewLayout()
    }
    
    private func setTitleLabelLayout() {
        if !self.contentView.subviews.contains(titleLabel) {
            self.contentView.addSubview(titleLabel)
        }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0),
                titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10.0)
            ]
        )
    }
    
    private func setScrollViewLayout() {
        if !self.contentView.subviews.contains(scrollView) {
            self.contentView.addSubview(scrollView)
            scrollView.addSubview(fiveDaysStackView)
        }
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        fiveDaysStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                scrollView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                scrollView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,constant: 10.0),
                scrollView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
                
                fiveDaysStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
                fiveDaysStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
                fiveDaysStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor)
            ]
        )
    }
}
