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
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingsCell")
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.units.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingsItem = settingsViewModel.units[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        cell.textLabel?.text = settingsItem.displayName
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25.0, weight: .bold)
        cell.textLabel?.textColor = .white
        
        if settingsItem == settingsViewModel.selectedUnit {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let settingsItem = settingsViewModel.units[indexPath.row]
        
        if settingsItem == settingsViewModel.selectedUnit {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.visibleCells.forEach { cell in
            cell.accessoryType = .none
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            let unit = Unit.allCases[indexPath.row]
            self.selectedUnit = unit
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
}
