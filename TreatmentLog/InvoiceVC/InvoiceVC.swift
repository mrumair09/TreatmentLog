//
//  InvoiceVC.swift
//  TreatmentLog
//
//  Created by Umair Yousaf on 01/12/2022.
//

import UIKit
import CoreData

class InvoiceVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    var InvoiceRecordData = [NSFetchRequestResult]()
    var InvoiceData = [NSFetchRequestResult]()
    var result: NSManagedObject!
    var invoiceResult: NSManagedObject!
    let entityRecord = "InvoiceRecord"
    let entity = "Inovice"
    var dataArr = [String : String] ()
    var totalfee :Float = 0.0
    
    @IBOutlet weak var invoiceTable: UITableView!
    @IBOutlet weak var txtTotalFeeCharges: UITextField!
    @IBOutlet weak var txtTotalFeeAmount: UITextField!
    @IBOutlet weak var txtOtherCharges1Text: UITextField!
    @IBOutlet weak var txtOtherCharges1Amount: UITextField!
    @IBOutlet weak var txtOtherCharges2Text: UITextField!
    @IBOutlet weak var txtOtherCharges2Amount: UITextField!
    @IBOutlet weak var txtOtherCharges3Text: UITextField!
    @IBOutlet weak var txtOtherCharges3Amount: UITextField!
    @IBOutlet weak var txtOtherCharges4Text: UITextField!
    @IBOutlet weak var txtOtherCharges4Amount: UITextField!
    
    @IBOutlet weak var lblOtherChargesTotal: UILabel!
    
    @IBOutlet weak var txtLaserFee1Text: UITextField!
    @IBOutlet weak var txtLaserFee1Amount: UITextField!
    @IBOutlet weak var txtLaserFee2Text: UITextField!
    @IBOutlet weak var txtLaserFee2Amount: UITextField!
    @IBOutlet weak var txtLaserFee3Text: UITextField!
    @IBOutlet weak var txtLaserFee3Amount: UITextField!
    @IBOutlet weak var txtLaserFee4Text: UITextField!
    @IBOutlet weak var txtLaserFee4Amount: UITextField!
    
    @IBOutlet weak var lblLaserFeeTotal: UILabel!
    @IBOutlet weak var lblGrandTotal: UILabel!
    
    @IBOutlet weak var txtStartTime: UITextField!
    @IBOutlet weak var txtFinishTime: UITextField!
    @IBOutlet weak var txtTotalHours: UITextField!
    
    @IBOutlet weak var addressTextView: UITextView!
    
    @IBOutlet weak var txtDate: UITextField!
    
    @IBOutlet weak var lblTechnicianName: UILabel!
    @IBOutlet weak var lblPysicianPractice: UILabel!
    
    @IBOutlet weak var lblPage: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        invoiceTable.delegate = self
        invoiceTable.dataSource = self
        self.navigationController?.navigationBar.isHidden = true
        invoiceTable.register(UINib(nibName: "InvoiceTVC", bundle: nil), forCellReuseIdentifier: "InvoiceTVC")
        
        txtDate.delegate = self
        txtOtherCharges1Amount.delegate = self
        txtLaserFee1Amount.delegate = self
        
        decorateUI()
        
//        InvoiceRecordData = DataManager.shared.retrieveData(entity: entityRecord)
        let data = DataManager.shared.retrieveData(entity: entityRecord)
        
        
        
        InvoiceData = DataManager.shared.retrieveData(entity: entity)
        
        if (InvoiceData.count != 0){
            invoiceResult = InvoiceData[0] as? NSManagedObject
//            DataManager.shared.deleteAllData(entity: entity)
            setupData()
        }
        calculateTotal()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        savedata()
    }
    
    func decorateUI(){
        addborder()

        lblAddress.text = " Aesthetic Mobile Laser Services, Inc \n PO Box 8550 \n Deerfield Beach, FL 33443 \n Tel:  (954) 480-2600 \n Fax: (954) 480-6020"
        let techniciandata  = DataManager.shared.retrieveData(entity: "Technician")
        if (techniciandata.count != 0){
            let result = techniciandata[0] as? NSManagedObject
            var name  = result?.value(forKey: "name") as! String
            lblTechnicianName.text = "TECHNICIAN: \(name ?? "")"
        }
       
    }
    
    
    func addborder(){
        
        txtTotalFeeCharges.layer.borderColor =  UIColor.black.cgColor
        txtTotalFeeAmount.layer.borderColor =  UIColor.black.cgColor
        txtOtherCharges1Text.layer.borderColor =  UIColor.black.cgColor
        txtOtherCharges1Amount.layer.borderColor =  UIColor.black.cgColor
        txtOtherCharges2Text.layer.borderColor =  UIColor.black.cgColor
        txtOtherCharges2Amount.layer.borderColor =  UIColor.black.cgColor
        txtOtherCharges3Text.layer.borderColor =  UIColor.black.cgColor
        txtOtherCharges3Amount.layer.borderColor =  UIColor.black.cgColor
        txtOtherCharges4Text.layer.borderColor =  UIColor.black.cgColor
        txtOtherCharges4Amount.layer.borderColor =  UIColor.black.cgColor
        txtLaserFee1Text.layer.borderColor =  UIColor.black.cgColor
        txtLaserFee1Amount.layer.borderColor =  UIColor.black.cgColor
        txtLaserFee2Text.layer.borderColor =  UIColor.black.cgColor
        txtLaserFee2Amount.layer.borderColor =  UIColor.black.cgColor
        txtLaserFee3Text.layer.borderColor =  UIColor.black.cgColor
        txtLaserFee3Amount.layer.borderColor =  UIColor.black.cgColor
        txtLaserFee4Text.layer.borderColor =  UIColor.black.cgColor
        txtLaserFee4Amount.layer.borderColor =  UIColor.black.cgColor
        txtStartTime.layer.borderColor =  UIColor.black.cgColor
        txtFinishTime.layer.borderColor =  UIColor.black.cgColor
        txtTotalHours.layer.borderColor =  UIColor.black.cgColor
        txtDate.layer.borderColor =  UIColor.black.cgColor
        addressTextView.layer.borderColor =  UIColor.black.cgColor

        txtTotalFeeCharges.layer.borderWidth  = 0.5
        txtTotalFeeAmount.layer.borderWidth  = 0.5
        txtOtherCharges1Text.layer.borderWidth  = 0.5
        txtOtherCharges1Amount.layer.borderWidth  = 0.5
        txtOtherCharges2Text.layer.borderWidth  = 0.5
        txtOtherCharges2Amount.layer.borderWidth  = 0.5
        txtOtherCharges3Text.layer.borderWidth  = 0.5
        txtOtherCharges3Amount.layer.borderWidth  = 0.5
        txtOtherCharges4Text.layer.borderWidth  = 0.5
        txtOtherCharges4Amount.layer.borderWidth  = 0.5
        txtLaserFee1Text.layer.borderWidth  = 0.5
        txtLaserFee1Amount.layer.borderWidth  = 0.5
        txtLaserFee2Text.layer.borderWidth  = 0.5
        txtLaserFee2Amount.layer.borderWidth  = 0.5
        txtLaserFee3Text.layer.borderWidth  = 0.5
        txtLaserFee3Amount.layer.borderWidth  = 0.5
        txtLaserFee4Text.layer.borderWidth  = 0.5
        txtLaserFee4Amount.layer.borderWidth  = 0.5
        txtStartTime.layer.borderWidth  = 0.5
        txtFinishTime.layer.borderWidth  = 0.5
        txtTotalHours.layer.borderWidth  = 0.5
        txtDate.layer.borderWidth  = 0.5
        addressTextView.layer.borderWidth  = 0.5
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return InvoiceRecordData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceTVC", for: indexPath) as! InvoiceTVC
        cell.setContent(dataArr:InvoiceRecordData[indexPath.row] as! NSManagedObject)
        
        return cell
    }

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        
        DataManager.shared.deleteAllData(entity: entity)
        DataManager.shared.deleteAllData(entity: "InvoiceRecord")
        
    }
    
    @IBAction func shareAction(_ sender: Any) {
        
        
        
    }
    
    @IBAction func addAction(_ sender: Any) {
        
        let vc = InvoiceSettingVC(nibName: "InvoiceSettingVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        calculateTotal()
    }
    
    
    
    func  textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField == txtDate){
            
            return false
        }
        calculateTotal()
        return true
    }
    
    func setupData(){
        
        addressTextView.text = invoiceResult.value(forKey: "comment") as? String ?? ""
        txtDate.text = invoiceResult.value(forKey: "date") as? String ?? ""
//        lblGrandTotal.text = invoiceResult.value(forKey: "dueAmount") as? String ?? ""
        txtFinishTime.text = invoiceResult.value(forKey: "endTime") as? String ?? ""
        txtOtherCharges1Text.text = invoiceResult.value(forKey: "otherChargesName1") as? String ?? ""
        txtOtherCharges2Text.text = invoiceResult.value(forKey: "otherChargesName2") as? String ?? ""
        txtOtherCharges3Text.text = invoiceResult.value(forKey: "otherChargesName3") as? String ?? ""
        txtOtherCharges4Text.text = invoiceResult.value(forKey: "otherChargesName4") as? String ?? ""
        txtOtherCharges1Amount.text = "$\(invoiceResult.value(forKey: "otherChargesValue1") as? String ?? "")"
        txtOtherCharges2Amount.text = "$\(invoiceResult.value(forKey: "otherChargesValue2") as? String ?? "")"
        txtOtherCharges3Amount.text = "$\(invoiceResult.value(forKey: "otherChargesValue3") as? String ?? "")"
        txtOtherCharges4Amount.text = "$\(invoiceResult.value(forKey: "otherChargesValue4") as? String ?? "")"
        
        txtLaserFee1Text.text = invoiceResult.value(forKey: "laserRentName1") as? String ?? ""
        txtLaserFee2Text.text = invoiceResult.value(forKey: "laserRentName2") as? String ?? ""
        txtLaserFee3Text.text = invoiceResult.value(forKey: "laserRentName3") as? String ?? ""
        txtLaserFee4Text.text = invoiceResult.value(forKey: "laserRentName4") as? String ?? ""
        txtLaserFee1Amount.text = "$\(invoiceResult.value(forKey: "laserRentValue1") as? String ?? "")"
        txtLaserFee2Amount.text = "$\(invoiceResult.value(forKey: "laserRentValue2") as? String ?? "")"
        txtLaserFee3Amount.text = "$\(invoiceResult.value(forKey: "laserRentValue3") as? String ?? "")"
        txtLaserFee4Amount.text = "$\(invoiceResult.value(forKey: "laserRentValue4") as? String ?? "")"
        
        txtStartTime.text = invoiceResult.value(forKey: "startTime") as? String ?? ""
        txtTotalFeeCharges.text = invoiceResult.value(forKey: "totalChargesName") as? String ?? ""
        txtTotalFeeAmount.text = invoiceResult.value(forKey: "totalChargesValue") as? String ?? ""
        txtTotalHours.text = invoiceResult.value(forKey: "totalTime") as? String ?? ""
     
    }
    
    func savedata(){
        
        dataArr["comment"] = addressTextView.text ?? ""
        dataArr["date"] = txtDate.text ?? ""
//        dataArr["dueAmount"] = lblGrandTotal.text ?? ""
        dataArr["endTime"] = txtFinishTime.text ?? ""
        
        dataArr["otherChargesName1"] = txtOtherCharges1Text.text ?? ""
        dataArr["otherChargesName2"] = txtOtherCharges2Text.text ?? ""
        dataArr["otherChargesName3"] = txtOtherCharges3Text.text ?? ""
        dataArr["otherChargesName4"] = txtOtherCharges4Text.text ?? ""
        dataArr["otherChargesValue1"] = txtOtherCharges1Amount.text?.replacingOccurrences(of: "$", with: "", options: .literal, range: nil) ?? ""
        dataArr["otherChargesValue2"] = txtOtherCharges2Amount.text?.replacingOccurrences(of: "$", with: "", options: .literal, range: nil) ?? ""
        dataArr["otherChargesValue3"] = txtOtherCharges3Amount.text?.replacingOccurrences(of: "$", with: "", options: .literal, range: nil) ?? ""
        dataArr["otherChargesValue4"] = txtOtherCharges4Amount.text?.replacingOccurrences(of: "$", with: "", options: .literal, range: nil) ?? ""
        
        dataArr["laserRentName1"] = txtLaserFee1Text.text ?? ""
        dataArr["laserRentName2"] = txtLaserFee2Text.text ?? ""
        dataArr["laserRentName3"] = txtLaserFee3Text.text ?? ""
        dataArr["laserRentName4"] = txtLaserFee4Text.text ?? ""
        dataArr["laserRentValue1"] = txtLaserFee1Amount.text?.replacingOccurrences(of: "$", with: "", options: .literal, range: nil) ?? ""
        dataArr["laserRentValue2"] = txtLaserFee2Amount.text?.replacingOccurrences(of: "$", with: "", options: .literal, range: nil) ?? ""
        dataArr["laserRentValue3"] = txtLaserFee3Amount.text?.replacingOccurrences(of: "$", with: "", options: .literal, range: nil) ?? ""
        dataArr["laserRentValue4"] = txtLaserFee4Amount.text?.replacingOccurrences(of: "$", with: "", options: .literal, range: nil) ?? ""

        dataArr["startTime"] = txtStartTime.text ?? ""
        dataArr["totalChargesName"] = txtTotalFeeCharges.text ?? ""
        dataArr["totalChargesValue"] = txtTotalFeeAmount.text ?? ""
        dataArr["totalTime"] = txtTotalHours.text ?? ""
        
        

        if (InvoiceData.count != 0){
            DataManager.shared.updateInvoiceData(entity: entity, dataArr: dataArr)
        }else{
            DataManager.shared.saveData(entity: entity, dataArr: dataArr)
        }
       
        
    }
    
    
    
    func calculateTotal(){
        
        var totalfeeCharges:Float = 0.0 , otherCharges1  : Float  = 0.0 , otherCharges2  : Float = 0.0 , otherCharges3  : Float = 0.0 , otherCharges4  : Float = 0.0 , laserRent1 : Float = 0.0 ,  laserRent2 : Float = 0.0 , laserRent3 : Float = 0.0 , laserRent4 : Float = 0.0
        
        
        if (txtTotalFeeAmount.text != nil){
            totalfeeCharges = Float( txtTotalFeeAmount.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")  ?? 0.0
        }
        if (txtOtherCharges1Amount.text != nil){
            otherCharges1 = Float( txtOtherCharges1Amount.text?.replacingOccurrences(of: "$", with: "", options: .literal, range: nil).trimmingCharacters(in: .whitespacesAndNewlines) ?? "")  ?? 0.0
        }
        if (txtOtherCharges2Amount.text != nil){
            otherCharges2 = Float( txtOtherCharges2Amount.text?.replacingOccurrences(of: "$", with: "", options: .literal, range: nil).trimmingCharacters(in: .whitespacesAndNewlines) ?? "")  ?? 0.0
        }
        if (txtOtherCharges3Amount.text != nil){
            otherCharges3 = Float( txtOtherCharges3Amount.text?.replacingOccurrences(of: "$", with: "", options: .literal, range: nil).trimmingCharacters(in: .whitespacesAndNewlines) ?? "")  ?? 0.0
        }
        if (txtOtherCharges4Amount.text != nil){
            otherCharges4 = Float( txtOtherCharges4Amount.text?.replacingOccurrences(of: "$", with: "", options: .literal, range: nil).trimmingCharacters(in: .whitespacesAndNewlines) ?? "")  ?? 0.0
        }
        
        if (txtLaserFee1Amount.text != nil){
            laserRent1 = Float( txtLaserFee1Amount.text?.replacingOccurrences(of: "$", with: "", options: .literal, range: nil).trimmingCharacters(in: .whitespacesAndNewlines) ?? "")  ?? 0.0
        }
        if (txtLaserFee2Amount.text != nil){
            laserRent2 = Float( txtLaserFee2Amount.text?.replacingOccurrences(of: "$", with: "", options: .literal, range: nil).trimmingCharacters(in: .whitespacesAndNewlines) ?? "")  ?? 0.0
        }
        if (txtLaserFee3Amount.text != nil){
            laserRent3 = Float( txtLaserFee3Amount.text?.replacingOccurrences(of: "$", with: "", options: .literal, range: nil).trimmingCharacters(in: .whitespacesAndNewlines) ?? "")  ?? 0.0
        }
        if (txtLaserFee4Amount.text != nil){
            laserRent4 = Float( txtLaserFee4Amount.text?.replacingOccurrences(of: "$", with: "", options: .literal, range: nil).trimmingCharacters(in: .whitespacesAndNewlines) ?? "")  ?? 0.0
        }
        
        var  otherChargesTotal:Float = otherCharges1 + otherCharges2 + otherCharges3 + otherCharges4
        var  laserRentTotal:Float = laserRent1 + laserRent2 + laserRent3 + laserRent4
        
        if (otherChargesTotal > 0){
            
            lblOtherChargesTotal.text = "\(otherChargesTotal)"
            
        }else{
            lblOtherChargesTotal.text = ""
        }
        if (laserRentTotal > 0){
            
            lblLaserFeeTotal.text = "\(laserRentTotal)"
            
        }else{
            lblOtherChargesTotal.text = ""
        }
        
        for item in InvoiceRecordData {

            guard let data  = item as? NSManagedObject else {return}
            
            if  let feeStr = data.value(forKey: "fee") as? String, let fee = Float(feeStr) {
                totalfee += fee
            }
            
        }
        
        lblGrandTotal.text = "\(otherChargesTotal + laserRentTotal + totalfee )"
       
    }
    
    
}


