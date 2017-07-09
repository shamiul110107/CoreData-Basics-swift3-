//
//  ViewController.swift
//  coreDataTest
//
//  Created by MobioApp on 7/4/17.
//  Copyright © 2017 MobioApp. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var myImageVeiw: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //save()
        fetch()
        //delete()
        
    }
    
    func delete () {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName : "User")
        
        do {
            
            let results = try managedContext.fetch(request)
            
            if results.count > 0 {
                for result in results {
                    if let username = result.value(forKey: "username") {
                        if String(describing: username) == "Alex" {
                            print("deleted")
                            managedContext.delete(result)
                            do {
                                try managedContext.save() // <- remember to put this :)
                            } catch {
                                // Do something... fatalerror
                            }
                        }
                    }
                }
            }
        } catch let error as NSError {
            print("Data Not Found. \(error), \(error.userInfo)")
        }
    }
    
    func fetch() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName : "User")
        
        do {
            
            let results = try managedContext.fetch(request)
            
            if results.count > 0 {
                for result in results {
                    if let username = result.value(forKey: "username") {
                        print(username)
                    }
                    if let password = result.value(forKey: "password") {
                        print(password)
                    }
                    if let imageData = result.value(forKey: "photo") as? Data {
                        if let image = UIImage(data:imageData) {
                            myImageVeiw.image = image
                        }
                    }
                }
            }
        } catch let error as NSError {
            print("Data Not Found. \(error), \(error.userInfo)")
        }
    }
    
    func save() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
       // let users = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedContext)

        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)
        let users = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        let img = UIImage(named: "image.jpg")
        let imgData = UIImageJPEGRepresentation(img!, 1)
        
        users.setValue("Alex", forKeyPath: "username")
        users.setValue("Alex123", forKeyPath: "password")
        users.setValue(imgData, forKey: "photo")
        
        do {
            try managedContext.save()
            print("SAVED")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}

