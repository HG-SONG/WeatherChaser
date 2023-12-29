//
//  WeatherDetailViewController.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/21.
//

import UIKit

class WeatherDetailViewController : UIViewController {
    private var collectionView : UICollectionView?
    private var weatherDetailViewModel = WeatherDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        makeCollectionView()
    }
    
    private func makeCollectionView() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex,_) -> NSCollectionLayoutSection? in
            
            return self.createSection(for: sectionIndex)
        }
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        self.collectionView!.backgroundColor = .black
        registerCells()
        view.addSubview(collectionView!)
    }
    
    private func registerCells() {
        self.collectionView!.register(LabelCell.self, forCellWithReuseIdentifier: LabelCell.identifier)
        self.collectionView!.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        self.collectionView!.register(FiveDaysWeatherCell.self, forCellWithReuseIdentifier: FiveDaysWeatherCell.identifier)
    }
    
    func setupViewModel(_ cellSummary : WeatherCellViewModel, completion: @escaping () -> Void) {
        
        self.weatherDetailViewModel.setupUpperSectionViewModel(cellSummary)
        self.weatherDetailViewModel.setupLowerSectionWithFetching(of: cellSummary.city){
            completion()
        }
    }
}

// MARK: Configure Compositional Layout
extension WeatherDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        case 2:
            return 4
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell
        
        switch indexPath.section {
        case 0 :
            cell = setSectionZeroAndOne(collectionView: collectionView, indexPath: indexPath)
        case 1 :
            cell = setSectionZeroAndOne(collectionView: collectionView, indexPath: indexPath)
        case 2 :
            cell = setSectionTwo(collectionView: collectionView, indexPath: indexPath)
        case 3 :
            cell = setSectionThree(collectionView: collectionView, indexPath: indexPath)
        default :
            cell = setSectionZeroAndOne(collectionView: collectionView, indexPath: indexPath) //임시
        }
        return cell
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        switch sectionIndex {
        case 0:
            return createTwoColumnSection(weightConstant: sectionIndex)
        case 1:
            return createSingleColumnSection()
        case 2:
            return createTwoColumnSection(weightConstant: sectionIndex)
        case 3:
            return createHorizontalScrollingSection()
        default:
            fatalError("Invalid section index")
        }
    }
    
    private func createTwoColumnSection(weightConstant :Int) -> NSCollectionLayoutSection {
        let weight = (Double(weightConstant) * 0.05)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.48), heightDimension: .fractionalHeight(0.98))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.1 + weight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.flexible(10.0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15.0
        
        return section
    }
    
    private func createSingleColumnSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.7))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.05))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func createHorizontalScrollingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

// MARK: Apply ViewModel By Section

extension WeatherDetailViewController {
    private func setSectionZeroAndOne(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        var text = ""
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCell.identifier, for: indexPath) as? LabelCell else {
            return UICollectionViewCell(frame: .zero)
        }
        
        if let viewModel = self.weatherDetailViewModel.modelAt(indexPath)?.getViewModelAsString?() {
            text = viewModel.first ?? "Error"
        }
        
        cell.setTitleLabel(text: text)
        return cell
    }
    
    private func setSectionTwo(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as? ImageCell else {
            return UICollectionViewCell(frame: .zero)
        }
        
        guard let viewModel = self.weatherDetailViewModel.modelAt(indexPath)?.getViewModelAsString?() else {
            return UICollectionViewCell(frame: .zero)
        }
        
        cell.setImageView(viewModel: viewModel)
        return cell
    }
    
    private func setSectionThree(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FiveDaysWeatherCell.identifier, for: indexPath) as? FiveDaysWeatherCell else {
            return UICollectionViewCell(frame: .zero)
        }
        
        guard let viewModel = self.weatherDetailViewModel.modelAt(indexPath)?.getViewModelAsObject?() else {
            return UICollectionViewCell(frame: .zero)
        }
        
        cell.commonInit()
        cell.setFiveDaysWeatherCell(viewModel)
        
        return cell
    }
}
