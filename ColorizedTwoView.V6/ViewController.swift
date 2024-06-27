//
//  ViewController.swift
//  ColorizedTwoView.V6
//
//  Created by Marat Fakhrizhanov on 27.06.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
        settingsVC.viewColor = view.backgroundColor
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        
    }
}

extension ViewController: SettingsViewControllerDelegate {
    func setColor(color: UIColor) {
        view.backgroundColor = color
    }
    
    
}

