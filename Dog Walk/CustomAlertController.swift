//
//  CustomAlertController.swift
//  Dog Walk
//
//  Created by Pavel Ivanov on 9/5/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

class AlertController: UIViewController {
    
    var delegate: CustomAlertDelegate!
    let imagePicker = UIImagePickerController()
    
    let viewAlert: UIView = {
        let alertView = UIView()
        alertView.backgroundColor = .white
        alertView.layer.cornerRadius = 18
        alertView.translatesAutoresizingMaskIntoConstraints = false
        return alertView
    }()
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "add")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "Add Pet"
        textLabel.textAlignment = .center
        textLabel.font = UIFont.boldSystemFont(ofSize: 18)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    let saveBatton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.999184072, green: 0.6600400209, blue: 0.1800208688, alpha: 1)
        button.layer.cornerRadius = 12
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
        return button
    }()
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .clear
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapedImage))
        image.addGestureRecognizer(singleTap)
        image.isUserInteractionEnabled = true
        
        imagePicker.delegate = self
        
        setupDesignAlert()
        setupAlertView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    @objc fileprivate func saveButton() {
        if image.image == UIImage(named: "add") {
            image.image = UIImage(named: "walk dog")
        }
        
        if textField.text == "" {
            textField.text = "Your Dog!"
        }
        
        
        delegate.setImageAndText(image: image.image!, text: textField.text!)
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func tapedImage() {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    fileprivate func setupAlertView() {
        view.addSubview(viewAlert)
        
        viewAlert.addSubview(textLabel)
        viewAlert.addSubview(image)
        viewAlert.addSubview(textField)
        viewAlert.addSubview(saveBatton)
        
        //constraint view
        viewAlert.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.size.width / 7).isActive = true
        viewAlert.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.size.height / 4).isActive = true
        view.bottomAnchor.constraint(equalTo: viewAlert.bottomAnchor, constant: view.frame.size.height / 3).isActive = true
        view.trailingAnchor.constraint(equalTo: viewAlert.trailingAnchor, constant: view.frame.size.width / 7).isActive = true
        
        //constrakint textLabel
        textLabel.centerXAnchor.constraint(equalTo: viewAlert.centerXAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: viewAlert.topAnchor, constant: 8).isActive = true
        
        //constraint imgView
        image.centerXAnchor.constraint(equalTo: viewAlert.centerXAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: 230).isActive = true
        image.heightAnchor.constraint(equalToConstant: 230).isActive = true
        image.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 8).isActive = true
        
        //constraint textLabel
        textField.leadingAnchor.constraint(equalTo: viewAlert.leadingAnchor, constant: 8).isActive = true
        viewAlert.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 8).isActive = true
        textField.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8).isActive = true
        //        imgView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8).isActive = true
        
        //constraint saveButton
        saveBatton.centerXAnchor.constraint(equalTo: viewAlert.centerXAnchor).isActive = true
        saveBatton.leadingAnchor.constraint(equalTo: viewAlert.leadingAnchor, constant: 50).isActive = true
        viewAlert.bottomAnchor.constraint(equalTo: saveBatton.bottomAnchor, constant: 8).isActive = true
    }
    
    fileprivate func setupDesignAlert() {
        viewAlert.layer.shadowColor = UIColor.gray.cgColor
        viewAlert.layer.shadowOpacity = 1
        viewAlert.layer.shadowOffset = .zero
        viewAlert.layer.shadowRadius = 10
    }
}

extension AlertController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickerImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image.image = pickerImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
