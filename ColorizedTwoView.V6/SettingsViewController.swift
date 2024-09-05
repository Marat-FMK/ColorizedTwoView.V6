//
//  SettingsViewController.swift
//  ColorizedTwoView.V6
//
//  Created by Marat Fakhrizhanov on 27.06.2024.
//

import UIKit


protocol SettingsViewControllerDelegate {
    func setColor(color: UIColor)
}

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var rgbView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var blueTF: UITextField!
    @IBOutlet weak var greenTF: UITextField!
    @IBOutlet weak var redTF: UITextField!
    
    var viewColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rgbView.layer.cornerRadius = 15
        redSlider.thumbTintColor = .red
        greenSlider.thumbTintColor = .green
        blueSlider.thumbTintColor = .blue
        
        setSliders()
        setRGBView()
        setValue(for: redTF,greenTF,blueTF)
        setLabels(redLabel,greenLabel,blueLabel)
//        redTF.delegate = self
//        greenTF.delegate = self       // либо через код (зажать control и тащить к значку viecontroller около выхода)
//        blueTF.delegate = self // work with delegate
    }
    
    private func string(slider: UISlider) -> String {
        let string = String(format: "%.2f", (slider.value))
        return string
    }
    
    private func setLabels(_ labels: UILabel...) {
        for label in labels {
            switch label {
            case redLabel: redLabel.text = string(slider: redSlider)
            case greenLabel: greenLabel.text = string(slider: greenSlider)
            default: blueLabel.text = string(slider: blueSlider)
            }
        }
    }
    
    private func setRGBView() {
        rgbView.backgroundColor = UIColor(_colorLiteralRed: redSlider.value,
                                          green: greenSlider.value,
                                          blue: blueSlider.value,
                                          alpha: 1)
    }
    
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTF: textField.text = string(slider: redSlider)
            case greenTF: textField.text = string(slider: greenSlider)
            default: textField.text = string(slider: blueSlider)
            }
        }
    }
    
    private func setSliders() {
        let ciColor = CIColor(color:viewColor)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
        
    }
    
    
    
    @IBAction func rgbSlidersTriggered(_ sender: UISlider) {
        
        
        switch sender {
        case redSlider: setValue(for: redTF)
            setLabels(redLabel)
        case greenSlider: setValue(for: greenTF)
            setLabels(greenLabel)
        default: setValue(for: blueTF)
            setLabels(blueLabel)
        }
        setRGBView()
    }
    
   
    
    @IBAction func doneButtonPressed() {
        guard let color = rgbView.backgroundColor else {return }
        delegate.setColor(color: color)}
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    private func showAlert(title: String , messege : String) {
        
        let alert = UIAlertController(title: title, message: messege, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
    
extension SettingsViewController: UITextFieldDelegate {
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            view.endEditing(true)
        }
        
    func textFieldDidEndEditing(_ textField: UITextField) {
            
            guard let text = textField.text else { return }
            
            if let current = Float(text) {
                switch textField {
                case redTF: redSlider.setValue(current, animated: true)
                    setLabels(redLabel)
                case greenTF: greenSlider.setValue(current, animated: true)
                    setLabels(greenLabel)
                default: blueSlider.setValue(current, animated: true)
                    setLabels(blueLabel)
                }
                setRGBView()
                return
            }
            showAlert(title: "Введите число", messege: "Внимательно")
        }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDone)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    }
    

