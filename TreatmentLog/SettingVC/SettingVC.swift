//
//  SettingVC.swift
//  TreatmentLog
//
//  Created by Umair Yousaf on 01/12/2022.
//

import UIKit
import CoreData

class SettingVC: UIViewController {
    var TechnicianData = [NSFetchRequestResult]()
    var result: NSManagedObject!
    let entity = "Technician"
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        if (DataManager.shared.entityIsEmpty(entity: self.entity)){
            debugPrint("+++++++++++++++++ empty data ++++++++++++++++++++")
        }else{
             TechnicianData = DataManager.shared.retrieveData(entity: "Technician")
            result = TechnicianData[0] as? NSManagedObject
            self.txtName.text = result.value(forKey: "name") as? String
            self.txtEmail.text = result.value(forKey: "email") as? String
        }
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        
        if (self.txtName.text ==  ""){
            
            showAlert(message: "Enter  your name")
            return
        }
        if (self.txtEmail.text ==  "Enter  your Email"){
            
            return
        }
        
        if (DataManager.shared.entityIsEmpty(entity: self.entity)){
            
            DataManager.shared.saveTechnicianInfo(entity:self.entity, name:self.txtName.text ?? "", email: self.txtEmail.text  ?? "")
        }else{
            
            DataManager.shared.updateTeechnicianData(entity: entity, searchKey: "name", searchValue: result.value(forKey: "name") as? String ?? "", name: self.txtName.text ?? "", email: self.txtEmail.text ?? "")
        }
        
        showAlert(message: "Data saved sucessfully")
      
    }
    @IBAction func clearTapped(_ sender: Any) {
        
        DataManager.shared.deleteAllData(entity:self.entity)
        txtName.text = ""
        txtEmail.text = ""
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert(message: String){
        
        let alert = UIAlertController(title: "Status", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            @unknown default:
                print("default")
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
