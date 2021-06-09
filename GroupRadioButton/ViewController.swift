//
//  ViewController.swift
//  GroupRadioButton
//
//  Created by Windy on 09/06/21.
//

import UIKit

class ViewController: UIViewController {

    private var label: UILabel!
    private var radioGroup: RadioButtonGroup!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let radioGroup = RadioButtonGroup()
        
        radioGroup.addRadio(radioButtons: [
            "Tiger", "Dolphin", "Lion", "Camel"
        ])
        
        radioGroup.didOnSelected = { [weak self] data in
            // Do something here
            self?.label.text = data
        }
        
        radioGroup.spacing = 8
        radioGroup.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(radioGroup)

        NSLayoutConstraint.activate([
            radioGroup.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            radioGroup.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        label = UILabel()
        label.text = "Not Selected"
        label.font = .preferredFont(forTextStyle: .title2)
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: radioGroup.topAnchor, constant: -32)
        ])
    }

}
