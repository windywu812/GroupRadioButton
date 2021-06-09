//
//  RadioButtonGroup.swift
//  GroupRadioButton
//
//  Created by Windy on 09/06/21.
//

import UIKit

class RadioButtonGroup: UIStackView {
    
    var didOnSelected: ((String) -> ())?
    
    func addRadio(radioButtons: [String]) {
        
        let radioButtons: [RadioButton] = radioButtons.map({
            let radioButton = RadioButton()
            radioButton.labelText = $0
            return radioButton
        })
        
        radioButtons.forEach { radio in
            
            addArrangedSubview(radio)
            
            radio.onSelected = { [weak self] (data, selectedRadio) in
                
                self?.didOnSelected?(data)
                
                self?.arrangedSubviews.forEach { radio in
                    let radio = radio as! RadioButton
                    if radio != selectedRadio {
                        radio.isSelected = false
                    } else {
                        radio.isSelected = true
                    }
                }
                
            }
        }
    }
        
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

fileprivate class RadioButton: UIView {
    
    /// Update the label
    var labelText: String = "" {
        didSet {
            labelView.text = labelText
        }
    }
    
    /// Update the check box state
    fileprivate var isSelected: Bool = false {
        didSet {
            updateState()
        }
    }
    
    /// Send the checkbox's data
    fileprivate var onSelected: ((String, RadioButton) -> ())?
    
    private var button: UIView!
    private var labelView: UILabel!
    private var shadowView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        button = UIView()
        button.layer.borderWidth = 2
        button.layer.borderColor = #colorLiteral(red: 0.09015055746, green: 0.4816651344, blue: 0.6673341393, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        
        labelView = UILabel()
        labelView.font = UIFont(name: "CentraleSansPro-Medium", size: 14)
        labelView.textColor = .black
        
        let stack = UIStackView(arrangedSubviews: [button, labelView])
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 8
        addSubview(stack)
        
        shadowView = UIView()
        shadowView.layer.cornerRadius = 6
        addSubview(shadowView)

        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 20),
            button.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadowView.widthAnchor.constraint(equalToConstant: 12),
            shadowView.heightAnchor.constraint(equalToConstant: 12),
            shadowView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            shadowView.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(sender:)))
        addGestureRecognizer(tap)
    }
    
    @objc private func tapGesture(sender: UITapGestureRecognizer) {
        isSelected = !isSelected
        onSelected?(labelText, self)
    }
    
    private func updateState() {
        if isSelected {
            UIView.animate(withDuration: 0.3) {
                self.shadowView.layer.backgroundColor = #colorLiteral(red: 0.09015055746, green: 0.4816651344, blue: 0.6673341393, alpha: 1).cgColor
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.shadowView.layer.backgroundColor = UIColor.white.cgColor
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
