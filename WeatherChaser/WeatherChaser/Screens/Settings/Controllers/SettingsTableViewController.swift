//
//  SettingsTableViewController.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import UIKit

class SettingsTableViewController : UITableViewController {
    
    private var settingsViewModel = SettingsViewModel()
    private var selectedUnit : Unit?
    private var saveButton : UIBarButtonItem!
    var delegate : SaveDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBarButtons()
        self.view.backgroundColor = .black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectedUnit = settingsViewModel.selectedUnit
    }
    
    private func setBarButtons() {
        self.saveButton = UIBarButtonItem(title: "Save", style: .plain, target:self, action: #selector(saveButtonTouched))
        
        self.navigationItem.setRightBarButton(saveButton, animated: true)
    }
    
    @objc private func saveButtonTouched() {
        self.settingsViewModel.selectedUnit = self.selectedUnit!
        delegate?.saveButtonTouched()
    }
}
