//
//  DataManager.swift
//  TreatmentLog
//
//  Created by Umair Yousaf on 17/12/2022.
//

import Foundation
import CoreData
import UIKit


class DataManager {
  static let shared = DataManager()
   private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveTechnicianInfo(entity:String, name:String, email: String){

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: entity, in: managedContext)!
        let tech = NSManagedObject(entity: userEntity, insertInto: managedContext)
        tech.setValue(name, forKeyPath: "name")
        tech.setValue(email, forKey: "email")

        do {
            try managedContext.save()
           
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func retrieveData(entity: String) -> [any NSFetchRequestResult] {
        
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        do {
            let result = try managedContext.fetch(fetchRequest)
//            for data in result as! [NSManagedObject] {
//
//                self.txtName.text = data.value(forKey: "name") as? String
//                self.txtEmail.text = data.value(forKey: "email") as? String
//            }
            return result
            
        } catch {
            
            print("Failed")
        }
        return [NSFetchRequestResult]()
    }
    
    func updateTeechnicianData(entity : String, searchKey:String, searchValue: String, name: String, email:String){
    
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
    
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entity)
            fetchRequest.predicate = NSPredicate(format: "\(searchKey) = %@", searchValue)
            do
            {
                let test = try managedContext.fetch(fetchRequest)
    
                let objectUpdate = test[0] as! NSManagedObject
                objectUpdate.setValue(name, forKeyPath: "name")
                objectUpdate.setValue(email, forKeyPath: "email")
                do{
                    try managedContext.save()
                }
                catch{
                    print(error)
                }
            }
            catch{
                print(error)
            }
    
        }
    
//    func deleteAllData(entity: String)
//    {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
//        fetchRequest.returnsObjectsAsFaults = false
//
//        do
//        {
//            let results = try managedContext.fetch(fetchRequest)
//            for managedObject in results
//            {
//                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
//                managedContext.delete(managedObjectData)
//            }
//        } catch let error as NSError {
//            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
//        }
//    }
    
    func deleteAllData(entity :String){
       guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
       let managedContext = appDelegate.persistentContainer.viewContext
       let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)

       do
       {
           let test = try managedContext.fetch(fetchRequest)
           for managedObject in test{
               let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
               managedContext.delete(managedObjectData)
           }
           
           do{
               try managedContext.save()
           }
           catch{
               print(error)
           }
           
       }
       catch
       {
           print(error)
       }
   }
    
    func entityIsEmpty(entity: String) -> Bool
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        var results : NSArray?

        do {
            results = try managedContext.fetch(fetchRequest) as NSArray

            return results?.count == 0

        } catch let error as NSError {
            // failure
            print("Error: \(error.debugDescription)")
            return true
        }
    }
    
    
    func saveData(entity:String, dataArr: [String:String]){

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: entity, in: managedContext)!
        let tech = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        for index in dataArr {
            
            tech.setValue(index.value, forKeyPath: index.key)
//            print("\(value.key) is set to \(value.value)")
        }
        

        do {
            try managedContext.save()
           
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func updateInvoiceData(entity:String, dataArr: [String:String]){
    
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
    
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entity)
//            fetchRequest.predicate = NSPredicate(format: "\(searchKey) = %@", searchValue)
            do
            {
                let test = try managedContext.fetch(fetchRequest)
    
                let objectUpdate = test[0] as! NSManagedObject
                
                for index in dataArr {
                    
                    objectUpdate.setValue(index.value, forKeyPath: index.key)
        //            print("\(value.key) is set to \(value.value)")
                }
                
                do{
                    try managedContext.save()
                }
                catch{
                    print(error)
                }
            }
            catch{
                print(error)
            }
    
        }
    
    
}
