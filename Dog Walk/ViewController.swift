//
//  ViewController.swift
//  Dog Walk
//
//  Created by Pavel Ivanov on 9/5/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var imagePets: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    fileprivate let cellIdentifire = "cell"
    
    fileprivate var currentDog: Dog!
    var managedContext: NSManagedObjectContext!
    
    
    fileprivate lazy var dateFormater: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .medium
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        loadData()
        if currentDog == nil {
            return
        } else {
            if let image = UIImage(data: currentDog.image! as Data) {
                imagePets.image = image
            }
            navigationItem.title = currentDog.name
        }
    }
    
    func loadData() {
        let fetchDog: NSFetchRequest<Dog> = Dog.fetchRequest()
        
        do {
            let results = try managedContext.fetch(fetchDog)
            
            if results.count > 0 {
                currentDog = results.first
            } else {
                return
            }
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifire)
    }

    @IBAction func addWalkButton(_ sender: UIBarButtonItem) {
        let walk = Walk(context: managedContext)
        walk.date = NSDate()
        
        if let dog = currentDog, let walks = dog.walks?.mutableCopy() as? NSMutableOrderedSet {
            walks.add(walk)
            dog.walks = walks
        }
        
        try? managedContext.save()
        
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDog?.walks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath)
        guard let walks = currentDog?.walks?[indexPath.row] as? Walk,
            let date = walks.date as Date? else { return cell }
        
        cell.textLabel?.text = dateFormater.string(from: date as Date)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let walksToRemove = currentDog?.walks?[indexPath.row] as? Walk,
            editingStyle == .delete else { return }
        
        managedContext.delete(walksToRemove)
        
        do {
            try managedContext.save()
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch let error as NSError {
            print(error)
        }
    }
}

//MARK: PopoverView

extension ViewController: UIPopoverPresentationControllerDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPopover" {
            let popowerViewController = segue.destination as! PopoverViewController
            popowerViewController.delegate = self
            popowerViewController.popoverPresentationController?.delegate = self
        }
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

extension ViewController: CurentPetDelegate {
    func didSelectPetDelegate(dog: Dog) {
        currentDog = dog
        
        if let image = UIImage(data: currentDog.image! as Data) {
            imagePets.image = image
        }
        navigationItem.title = currentDog.name
        
        tableView.reloadData()
    }
}

