//
//  SettingsTableViewController.swift
//  WeatherChaser
//
//  Created by SONG on 2023/12/05.
//

import UIKit

class SettingsTableViewController : UITableViewController {
    
    var delegate : SaveDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
}
