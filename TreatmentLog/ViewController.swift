//
//  ViewController.swift
//  TreatmentLog
//
//  Created by Umair Yousaf on 29/11/2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var invoiceBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func settingTapped(_ sender: Any) {
        let vc = SettingVC(nibName: "SettingVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func invoiceTapped(_ sender: UIButton) {
        let vc = InvoiceVC(nibName: "InvoiceVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
//        ToolTip.shared()?.showPopTipTutorial(pointedView: sender)
        
        
    }
}

