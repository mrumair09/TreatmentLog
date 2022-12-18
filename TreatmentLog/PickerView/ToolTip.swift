//
//  ToolTip.swift
//  TreatmentLog
//
//  Created by Umair Yousaf on 10/12/2022.
//

import UIKit
import AMPopTip

class ToolTip: UIView {
    
    private let popTip:PopTip = PopTip()
    
    private var dataArr = [String?]()
    private weak var selectdTxtField : UITextField!
    private var selectdTxtFieldTag : Int!
    @IBOutlet weak var tableView: UITableView!
    var onClickListener : ((String)->Void)? = nil
    static private var sharedInstance : ToolTip?
    
    static func shared()-> ToolTip? {
        if sharedInstance == nil {
            sharedInstance = Bundle.main.loadNibNamed("ToolTip", owner: self, options: nil)?.first as? ToolTip
        }
        
        return sharedInstance
    }
    
    
    func popTipConfigurations(){
        
        var frameSize = self.frame
        frameSize.size.width = 250
        self.frame = frameSize
        self.backgroundColor = UIColor.clear
        
        popTip.cornerRadius = 12
        popTip.edgeMargin = 12.0
        popTip.isUserInteractionEnabled = true
        popTip.shouldDismissOnTap = false
        popTip.bubbleColor = UIColor.systemGray6
        popTip.shouldDismissOnTapOutside = true
//        popTip.actionAnimation = .bounce(16.0)
        
        self.registerTVCell()
    }
    
    func registerTVCell(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ToolTipTVC", bundle: nil), forCellReuseIdentifier: "ToolTipTVC")
        
    }
    
    
    func showPopTipTutorial(pointedView: UIView){
        if let topVC = UIApplication.getTopViewController()?.view {
//            popTipConfigurations()
            popTip.show(customView: self, direction: .auto, in: topVC, from: pointedView.frame)
        }
    }
    
    func showMedicalLists(pointedView: UIView, data:[String], onClickListener : ((String)->Void)?){
        self.onClickListener = onClickListener
        dataArr.removeAll()
        dataArr = data
        self.tableView.reloadData()
        self.showPopTipTutorial(pointedView: pointedView)

    }
    
}


extension ToolTip : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToolTipTVC", for: indexPath) as! ToolTipTVC
        cell.lblTitle.text = dataArr[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.selectdTxtField.text = dataArr[indexPath.row]
        onClickListener?(dataArr[indexPath.row] ?? "")
        popTip.hide()
    }


}








