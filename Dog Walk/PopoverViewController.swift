//
//  PopoverViewController.swift
//  Dog Walk
//
//  Created by Pavel Ivanov on 9/5/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit
import CoreData

class PopoverViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var delButton: UIBarButtonItem!
    
    fileprivate let cellIdentifire = "cell"
    
    var editeMode = false
    
    fileprivate var dogs = [Dog]()
    
    var delegate: CurentPetDelegate!
    
    fileprivate let imagePicker = UIImagePickerController()
    
    //--Core Data
    fileprivate var managedContext: NSManagedObjectContext!
    fileprivate let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        
        //--Core Data
        managedContext = appDelegate?.coreDataStack.managerContext
        loadData()
    }
    
    fileprivate func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: 200, height: 140)
        layout?.sectionInset = UIEdgeInsets(top: 30, left: 20, bottom: 65, right: 20)
        layout?.minimumLineSpacing = 18

        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifire)
    }
    
    fileprivate func alert() {
        let alert = AlertController()
        alert.modalPresentationStyle = .overFullScreen
        alert.modalTransitionStyle = .crossDissolve
        present(alert, animated: true)
        
        alert.delegate = self
    }
    
    //--Core Data
    fileprivate func loadData() {
        let dogsRequest: NSFetchRequest<Dog> = Dog.fetchRequest()

        do {
            try dogs = managedContext.fetch(dogsRequest)
        } catch let error as NSError {
            print("Error: \(error)")
        }
        
        collectionView.reloadData()
    }
    
    @IBAction func addPets(_ sender: UIBarButtonItem) {
        alert()
    }
    
    @IBAction func deleteButton(_ sender: UIBarButtonItem) {
        if editeMode {
            editeMode = false
        } else {
            editeMode = true
        }
        
        collectionView.reloadData()
    }
}

extension PopoverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifire, for: indexPath) as! CollectionViewCell
        let dog = dogs[indexPath.row]
        
        if editeMode {
            cell.addToSubview()
        } else {
            cell.removeWithSubview()
        }
        
        cell.delegate = self
        
        cell.image.image = UIImage(data: dog.image! as Data)
        cell.nameLabel.text = dog.name
        
        return cell
    }
}

extension PopoverViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate.didSelectPetDelegate(dog: dogs[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}

extension PopoverViewController: CellSubclassDelegate {
    func buttonTapped(cell: CollectionViewCell) {
        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
        
        let dog = dogs[indexPath.row]
        managedContext.delete(dog)
        try? managedContext.save()
        loadData()
        
        collectionView.reloadData()
    }
}

extension PopoverViewController: CustomAlertDelegate {
    func setImageAndText(image: UIImage, text: String) {
        
        let dog = Dog(context: managedContext)
        dog.name = text
        dog.image = image.pngData() as NSData?
        
        try? managedContext.save()
        loadData()
    }
}

