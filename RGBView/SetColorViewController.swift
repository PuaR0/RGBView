//
//  ViewController.swift
//  RGBView
//
//  Created by Алиага С on 16.6.2022.
//

import UIKit

class SetColorViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTF: UITextField!
    @IBOutlet weak var greenTF: UITextField!
    @IBOutlet weak var blueTF: UITextField!
    
    var delegate: SetColorViewControllerDelegate!
    var viewColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        colorView.backgroundColor = viewColor
        
        setSliders()
        setValueForLabels(for: redLabel, greenLabel, blueLabel)
        setValueForTF(for: redTF, greenTF, blueTF)
    }
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        
        switch sender {
        case redSlider:
            setValueForLabels(for: redLabel)
            setValueForTF(for: redTF)
        case greenSlider:
            setValueForLabels(for: greenLabel)
            setValueForTF(for: greenTF)
        default:
            setValueForLabels(for: blueLabel)
            setValueForTF(for: blueTF)
        }
        
        setColor()
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setColor(colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
}

//MARK: - Privat methods

extension SetColorViewController {
    
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValueForLabels(for labels: UILabel...) {
        labels.forEach { label in
            switch label{
            case redLabel: label.text = string(from: redSlider)
            case greenLabel: label.text = string(from: greenSlider)
            default: label.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValueForTF(for textFields: UITextField...){
        textFields.forEach { textField in
            switch textField {
            case redTF: textField.text = string(from: redSlider)
            case greenTF: textField.text = string(from: greenSlider)
            default: textField.text = string(from: blueSlider)
            }
        }
    }
    
    private func setSliders() {
        let ciColor = CIColor(color: viewColor)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    private func showAlert(title: String, massage: String) {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

//MARK: - UITextFieldDelegate

extension SetColorViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if let currentVAlue = Float(text) {
            switch textField {
            case redTF:
                redSlider.setValue(currentVAlue, animated: true)
                setValueForLabels(for: redLabel)
            case greenTF:
                greenSlider.setValue(currentVAlue, animated: true)
                setValueForLabels(for: greenLabel)
            default:
                blueSlider.setValue(currentVAlue, animated: true)
                setValueForLabels(for: blueLabel)
            }
            setColor()
            return
        }
        showAlert(title: "Не верный формат!", massage: "Пожалуйста, введите корректные знвчения!")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolBar = UIToolbar()
        textField.inputAccessoryView = keyboardToolBar
        keyboardToolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: "Done", style: .done, target: self, action: #selector(didTapDone)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace, target: nil, action: nil
        )
        
        keyboardToolBar.items = [flexBarButton, doneButton]
    }
}

