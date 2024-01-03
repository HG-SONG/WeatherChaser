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
    private var fiveDaysStackView : UIStackView?
    private let scrollView = UIScrollView(frame: .zero)
    
    func commonInit() {
        self.titleLabel.text = "Weather forecast for 5 days"
        self.titleLabel.font = UIFont.systemFont(ofSize: 25.0,weight: .bold)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    func setFiveDaysWeatherCell(_ viewModel : [Any]) {
        guard let fiveDaysWeathers = viewModel as? [WeatherBy3hViewModel] else {
            return
        }
        
        if self.fiveDaysStackView != nil {
            self.fiveDaysStackView!.removeFromSuperview()
        }
        
        let tmpStackView = UIStackView()
        tmpStackView.axis = .horizontal
        tmpStackView.spacing = 10.0
        
        for item in fiveDaysWeathers {
            let smallStackView = WeatherBy3hView()
            smallStackView.commonInit(viewModel: item)
            tmpStackView.addArrangedSubview(smallStackView)
        }
        
        self.fiveDaysStackView = tmpStackView
        
        if self.fiveDaysStackView != nil {
            self.scrollView.addSubview(fiveDaysStackView!)
        }
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
        guard let fiveDaysStackView = self.fiveDaysStackView else {
            return
        }
        
        if !self.contentView.subviews.contains(scrollView) {
            self.contentView.addSubview(scrollView)
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
