//
//  MainViewController.swift
//  RGBView
//
//  Created by Алиага С on 26.6.2022.
//

import UIKit

protocol SetColorViewControllerDelegate {
    func setColor(_ color: UIColor)
}

class MainViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let setColorVC = segue.destination as! SetColorViewController
        setColorVC.delegate = self
        setColorVC.viewColor = view.backgroundColor
    }
}

extension MainViewController: SetColorViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
