//
//  ErrorCoordinator.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/30.
//

import UIKit

class ErrorCoordinator : Coordinator {
    private var presenter: UINavigationController
    private var viewController = ErrorViewController()
    
    init(presenter:UINavigationController) {
        self.presenter = presenter
    }
    
    func changeViewController() {
        presenter.pushViewController(viewController, animated: false)
    }
}

class ErrorViewController : UIViewController{
    private let backgroundImageView = UIImageView(image: UIImage(named: "loading.png"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.frame = view.bounds
        backgroundImageView.contentMode = .scaleToFill
        self.view.addSubview(backgroundImageView)
        ErrorManager.showExitAlert(error: .noAPIKey)
    }
}
