//
//  InvoiceSettingVC.swift
//  TreatmentLog
//
//  Created by Umair Yousaf on 01/12/2022.
//

import UIKit
import CoreData

class InvoiceSettingVC: UIViewController,UITextFieldDelegate {
    
    var isSplit : Bool  =  false
    var technicianData = [NSFetchRequestResult]()
    var result: NSManagedObject!
    var dataArr = [String : String] ()
//    var dataArr = [String:String]()
    let entity = "InvoiceRecord"
    
    @IBOutlet weak var txtPatient: UITextField!
    @IBOutlet weak var txtAreaTreated: UITextField!
    @IBOutlet weak var txtLaser: UITextField!
    @IBOutlet weak var txtWvLgth: UITextField!
    @IBOutlet weak var txtPulseW: UITextField!
    @IBOutlet weak var txtEnergy: UITextField!
    @IBOutlet weak var txtDensity: UITextField!
    @IBOutlet weak var txtPasses: UITextField!
    
    @IBOutlet weak var txtPtch: UITextField!
    @IBOutlet weak var txtDwell: UITextField!
    @IBOutlet weak var txtSpot: UITextField!
    @IBOutlet weak var txtCooling: UITextField!
    @IBOutlet weak var txtPulse: UITextField!
    
    @IBOutlet weak var txtNote: UITextField!
    @IBOutlet weak var txtFee: UITextField!
    
    @IBOutlet weak var btnSplitFee: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        txtLaser.delegate = self
        txtWvLgth.delegate = self
        txtCooling.delegate = self
        txtSpot.delegate = self
//        technicianData = DataManager.shared.retrieveData(entity: entity)
//        if (technicianData.count != 0){
//            result = technicianData[0] as? NSManagedObject
//            setupData()
//        }
        
    }
    
    func setupData(){
        
        txtAreaTreated.text = result.value(forKey: "areaTreated") as? String
        txtCooling.text = result.value(forKey: "cooling") as? String
        txtDensity.text = result.value(forKey: "density") as? String
        txtDwell.text = result.value(forKey: "dwell") as? String
        txtEnergy.text = result.value(forKey: "energy") as? String
        txtFee.text = result.value(forKey: "fee") as? String
        txtLaser.text = result.value(forKey: "laser") as? String
        txtNote.text = result.value(forKey: "notes") as? String
        txtPasses.text = result.value(forKey: "passes") as? String
        txtPatient.text = result.value(forKey: "patient") as? String
        txtPtch.text = result.value(forKey: "pitch") as? String
        txtPulse.text = result.value(forKey: "pulses") as? String
        txtPulseW.text = result.value(forKey: "pulseW") as? String
        txtSpot.text = result.value(forKey: "spot") as? String
        txtWvLgth.text = result.value(forKey: "wvlgth") as? String
        if ((result.value(forKey: "splitFee")) != nil){
            btnSplitFee.setImage(UIImage(named: "checked.png"), for: .normal)
        }else{
            btnSplitFee.setImage(UIImage(named: "unchecked.png"), for: .normal)
        }
        
//        txtAreaTreated.text = data.value(forKey: "areaTreated") as? String
        //        tech.setValue(name, forKeyPath: "areaTreated")
        //        tech.setValue(email, forKey: "cooling")
        //        tech.setValue(name, forKeyPath: "density")
        //        tech.setValue(email, forKey: "dwell")
        //        tech.setValue(name, forKeyPath: "energy")
        //        tech.setValue(email, forKey: "fee")
        //        tech.setValue(name, forKeyPath: "laser")
        //        tech.setValue(email, forKey: "notes")
        //        tech.setValue(name, forKeyPath: "passes")
        //        tech.setValue(email, forKey: "patient")
        //        tech.setValue(email, forKey: "pitch")
        //        tech.setValue(name, forKeyPath: "pulses")
        //        tech.setValue(email, forKey: "pulseW")
        //        tech.setValue(name, forKeyPath: "splitFee")
        //        tech.setValue(email, forKey: "spot")
        //        tech.setValue(name, forKeyPath: "wvlgth")
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        
        //        tech.setValue(name, forKeyPath: "areaTreated")
        //        tech.setValue(email, forKey: "cooling")
        //        tech.setValue(name, forKeyPath: "density")
        //        tech.setValue(email, forKey: "dwell")
        //        tech.setValue(name, forKeyPath: "energy")
        //        tech.setValue(email, forKey: "fee")
        //        tech.setValue(name, forKeyPath: "laser")
        //        tech.setValue(email, forKey: "notes")
        //        tech.setValue(name, forKeyPath: "passes")
        //        tech.setValue(email, forKey: "patient")
        //        tech.setValue(email, forKey: "pitch")
        //        tech.setValue(name, forKeyPath: "pulses")
        //        tech.setValue(email, forKey: "pulseW")
        //        tech.setValue(name, forKeyPath: "splitFee")
        //        tech.setValue(email, forKey: "spot")
        //        tech.setValue(name, forKeyPath: "wvlgth")
        
        if (txtPatient.text == ""){
            showAlert(message: "Please Enter Patiten Name")
            return
        }
        
        dataArr["patient"] = txtPatient.text ?? ""
        dataArr["areaTreated"] = txtNote.text ?? ""
        dataArr["cooling"] = txtCooling.text ?? ""
        dataArr["density"] = txtDensity.text ?? ""
        dataArr["dwell"] = txtDwell.text ?? ""
        dataArr["energy"] = txtEnergy.text ?? ""
        dataArr["fee"] = txtFee.text ?? ""
        dataArr["laser"] = txtLaser.text ?? ""
        dataArr["notes"] = txtNote.text ?? ""
        dataArr["passes"] = txtPasses.text ?? ""
        dataArr["pitch"] = txtPtch.text ?? ""
        dataArr["pulses"] = txtPulse.text ?? ""
        dataArr["pulseW"] = txtPulseW.text ?? ""
        dataArr["spot"] = txtSpot.text ?? ""
        if (isSplit){
            dataArr["splitFee"] = "1"
        }else{
            dataArr["splitFee"] = ""
        }
        DataManager.shared.saveData(entity: entity, dataArr: dataArr)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func splitFeeTapped(_ sender: Any) {
        
        if (isSplit ==  false) {
            btnSplitFee.setImage(UIImage(named: "unchecked.png"), for: .normal)
            isSplit = true
        }else{
            btnSplitFee.setImage(UIImage(named: "checked.png"), for: .normal)
            isSplit = false
        }
        
    }

    @IBAction func clearTapped(_ sender: Any) {
        
        DataManager.shared.deleteAllData(entity: entity)
        txtPatient.text = ""
        txtAreaTreated.text = ""
        txtLaser.text = ""
        txtWvLgth.text = ""
        txtPulseW.text = ""
        txtEnergy.text = ""
        txtSpot.text = ""
        txtCooling.text = ""
        txtPulse.text = ""
        txtNote.text = ""
        txtFee.text = ""
        txtDensity.text = ""
        txtDwell.text = ""
        txtPasses.text = ""
        txtPtch.text = ""
        btnSplitFee.setImage(UIImage(named: "unchecked.png"), for: .normal)
        isSplit = false
        
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(Double(txtFee.text!) ?? 0 > 0){
            btnSplitFee.isEnabled = true
            
        }else{
            
            btnSplitFee .setImage(UIImage(named: "unchecked.png"), for:.normal)
            
            btnSplitFee.isEnabled = false
            isSplit = false
        }
        
        if ( textField == txtLaser || textField == txtWvLgth || textField == txtCooling || textField == txtSpot){
            
            if (textField == self.txtLaser) {
                
                ToolTip.shared()?.showMedicalLists(pointedView: self.txtLaser, data: ["ALX","ATV","Co2","Ematrix","Fraxel","GYag","IPL","US","VBeam","VS","YAG"]) { message in
                    self.txtLaser.text = message
                    self.updateFields(textField: self.txtLaser)
                }
                
                
            }else if (textField == self.txtWvLgth){
                
                if(txtLaser.text == "ALX"){
                    ToolTip.shared()?.showMedicalLists(pointedView: self.txtWvLgth, data:["755"]){ message in
                        self.txtWvLgth.text = message
                    }
                }
                else if(txtLaser.text == "ATV"){
                    ToolTip.shared()?.showMedicalLists(pointedView: self.txtWvLgth, data:["755","532","1064"]){ message in
                        self.txtWvLgth.text = message
                    }
                }
                else if(txtLaser.text == "GYag"){
                    ToolTip.shared()?.showMedicalLists(pointedView: self.txtWvLgth, data:["1064"]){ message in
                        self.txtWvLgth.text = message
                    }
                }
                else if(txtLaser.text == "VBeam"){
                    ToolTip.shared()?.showMedicalLists(pointedView: self.txtWvLgth, data:["595"]){ message in
                        self.txtWvLgth.text = message
                    }
                }
                else if(txtLaser.text == "YAG"){

                    ToolTip.shared()?.showMedicalLists(pointedView: self.txtWvLgth, data:["532", "1064"]){ message in
                        self.txtWvLgth.text = message
                    }
                }
                else
                {
                    ToolTip.shared()?.showMedicalLists(pointedView: self.txtWvLgth, data:[" "]){ message in
                        self.txtWvLgth.text = message
                    }
                }
                
                //                    return false
            }else if (textField == txtSpot){
                
                if(txtLaser.text == "ALX")
                {
                    ToolTip.shared()?.showMedicalLists(pointedView: self.txtWvLgth, data:["6","8","10","12","15","18","20","22","24"]){ message in
                        self.txtSpot.text = message
                    }
                }else if(txtLaser.text == "ATV"){
                    
                    if(txtWvLgth.text == "755"){

                        ToolTip.shared()?.showMedicalLists(pointedView: self.txtWvLgth, data:["2", "3", "4"]){ message in
                            self.txtSpot.text = message
                        }
                    }else if(txtWvLgth.text ==  "532" || txtWvLgth.text == "1064"){

                        ToolTip.shared()?.showMedicalLists(pointedView: self.txtWvLgth, data:["2", "3", "5"]){ message in
                            self.txtSpot.text = message
                        }
                    }else{

                    }
                }else if(txtLaser.text == "GYag"){

                    ToolTip.shared()?.showMedicalLists(pointedView: self.txtWvLgth, data:["1.5","3","6","8","10","12","15","18","20","22","24"]){ message in
                        self.txtSpot.text = message
                    }
                }else if(txtLaser.text == "VBeam"){

                    ToolTip.shared()?.showMedicalLists(pointedView: self.txtWvLgth, data:["3x10","5", "7", "10"]){ message in
                        self.txtSpot.text = message
                    }
                }else if(txtLaser.text == "YAG"){

                    if(txtWvLgth.text == "532"){
                        ToolTip.shared()?.showMedicalLists(pointedView: self.txtWvLgth, data:["2","3","4","6"]){ message in
                            self.txtSpot.text = message
                        }
                    }else{

                        ToolTip.shared()?.showMedicalLists(pointedView: self.txtWvLgth, data:["3","4","6","8"]){ message in
                            self.txtWvLgth.text = message
                        }
                    }
                }
                else{
                    ToolTip.shared()?.showMedicalLists(pointedView: self.txtWvLgth, data:[""]){ message in
                        self.txtWvLgth.text = message
                    }
                }
            }else if textField == self.txtCooling {
                ToolTip.shared()?.showMedicalLists(pointedView: self.txtCooling, data: ["0","10","20","30","40","50","60"]){ message in
                    self.txtCooling.text = message
                }
                
            }else{
                
                
            }
            return false
        }
        return true
    }
    
    func updateFields(textField:UITextField){
        
        if (textField == txtLaser){
            if (textField.text == "ALX"){
                txtWvLgth.text = "755"
                txtPulseW.text = "3"
                txtSpot.text = ""
                txtCooling.text = ""
                
            }else if (textField.text == "Fraxel"){
                
                txtWvLgth.text = "1550"
                txtPulseW.text = "15"
                txtSpot.text = "Z"
                txtCooling.text = ""
                
            }else if (textField.text == "GYag"){
                
                txtWvLgth.text = "1064"
                txtPulseW.text = ""
                txtSpot.text = ""
                txtCooling.text = ""
                
            }else if (textField.text == "VBeam"){
                
                txtWvLgth.text = "595"
                txtPulseW.text = ""
                txtSpot.text = ""
                txtCooling.text = ""
                
            }else if (textField.text == "Co2"){
                
                txtWvLgth.text = "10600"
                txtPulseW.text = ""
                txtSpot.text = ""
                txtCooling.text = ""
                
            }else if (textField.text == "Ematrix"){
                
                txtWvLgth.text = "RF"
                txtPulseW.text = ""
                txtSpot.text = ""
                txtCooling.text = ""
                
            }else if (textField.text == "IPL"){
                
                txtWvLgth.text = "RF"
                txtPulseW.text = ""
                txtSpot.text = ""
                txtCooling.text = ""
                
            }else{
                txtWvLgth.text = ""
                txtPulseW.text = ""
                txtSpot.text = ""
                txtCooling.text = ""
            }
        }
        
    }
    
    func setSplitButton(){
        
        if (isSplit){
            btnSplitFee.setImage(UIImage(named: "checked.png"), for: .normal)
        }else{
            btnSplitFee.setImage(UIImage(named: "unchecked.png"), for: .normal)
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        if (textField  ==  txtLaser){
            txtWvLgth.text = ""
            txtSpot.text = ""
            txtCooling.text = ""
            txtPulseW.text = ""
        }
        return true
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


