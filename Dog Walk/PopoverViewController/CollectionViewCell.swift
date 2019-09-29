//
//  CollectionViewCell.swift
//  Dog Walk
//
//  Created by Pavel Ivanov on 9/5/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "1")
        image.layer.cornerRadius = 12
        image.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 12
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: CellSubclassDelegate?
    
    @objc func actionButton(sender: UIButton!) {
        delegate?.buttonTapped(cell: self)
    }
    
    func addToSubview() {
        contentView.addSubview(button)
        
        //button
        button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: button.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: button.topAnchor).isActive = true
        
        //addAction
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
    }
    
    func removeWithSubview() {
        button.removeFromSuperview()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // setting contentView
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 10
        contentView.backgroundColor = .white
        
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
            
        nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        

        //Add constraint
        image.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: image.trailingAnchor).isActive = true
        image.heightAnchor.constraint(equalToConstant: 103).isActive = true

        contentView.layer.cornerRadius = 12

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
