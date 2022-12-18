//
//  InvoiceTVC.swift
//  TreatmentLog
//
//  Created by Umair Yousaf on 01/12/2022.
//

import UIKit
import CoreData

class InvoiceTVC: UITableViewCell {

    
    @IBOutlet weak var txtPatient: UILabel!
    @IBOutlet weak var txtAreaTreated: UILabel!
    @IBOutlet weak var txtLaser: UILabel!
    @IBOutlet weak var txtWvLgth: UILabel!
    @IBOutlet weak var txtPulseW: UILabel!
    @IBOutlet weak var txtEnergy: UILabel!
    @IBOutlet weak var txtDensity: UILabel!
    @IBOutlet weak var txtPasses: UILabel!
    
    @IBOutlet weak var txtPtch: UILabel!
    @IBOutlet weak var txtDwell: UILabel!
    @IBOutlet weak var txtSpot: UILabel!
    @IBOutlet weak var txtCooling: UILabel!
    @IBOutlet weak var txtPulse: UILabel!
    
    @IBOutlet weak var txtNote: UILabel!
    @IBOutlet weak var txtFee: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(dataArr: NSManagedObject){
            txtAreaTreated.text = dataArr.value(forKey: "areaTreated") as? String
            txtCooling.text = dataArr.value(forKey: "cooling") as? String
            txtDensity.text = dataArr.value(forKey: "density") as? String
            txtDwell.text = dataArr.value(forKey: "dwell") as? String
            txtEnergy.text = dataArr.value(forKey: "energy") as? String
            txtFee.text = dataArr.value(forKey: "fee") as? String
            txtLaser.text = dataArr.value(forKey: "laser") as? String
            txtNote.text = dataArr.value(forKey: "notes") as? String
            txtPasses.text = dataArr.value(forKey: "passes") as? String
            txtPatient.text = dataArr.value(forKey: "patient") as? String
            txtPtch.text = dataArr.value(forKey: "pitch") as? String
            txtPulse.text = dataArr.value(forKey: "pulses") as? String
            txtPulseW.text = dataArr.value(forKey: "pulseW") as? String
            txtSpot.text = dataArr.value(forKey: "spot") as? String
            txtWvLgth.text = dataArr.value(forKey: "wvlgth") as? String
    }
    
}
