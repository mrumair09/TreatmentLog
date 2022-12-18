//
//  DatePickerToolTip.swift
//  TreatmentLog
//
//  Created by Umair Yousaf on 18/12/2022.
//

import UIKit
import AMPopTip

class DatePickerToolTip: UIView {
    
    private let datePickerToolTip:PopTip = PopTip()
    
    private var dataArr = [String?]()
    private weak var selectdTxtField : UITextField!
    private var selectdTxtFieldTag : Int!
    var date:String?
    var time:String?
    @IBOutlet weak var datepicker: UIDatePicker!
    
    @IBOutlet weak var donebtn: UIButton!
    var onClickListener : ((String)->Void)? = nil
    var onTimeClickListener : ((String)->Void)? = nil
    static private var sharedInstance : DatePickerToolTip?
    
    static func shared()-> DatePickerToolTip? {
        if sharedInstance == nil {
            sharedInstance = Bundle.main.loadNibNamed("DatePickerToolTip", owner: self, options: nil)?.first as? DatePickerToolTip
        }
        
        return sharedInstance
    }
    
    func popTipConfigurations(){
        
        var frameSize = self.frame
        frameSize.size.width = 250
        self.frame = frameSize
        self.backgroundColor = UIColor.clear
//        datePickerToolTip.backgroundColor = UIColor.lightGray
//        datePickerToolTip.alpha = 0.9
        
        
        datePickerToolTip.cornerRadius = 12
        datePickerToolTip.edgeMargin = 12.0
        datePickerToolTip.isUserInteractionEnabled = true
//        popTip.backgroundColor = UIColor.black
//        popTip.shouldShowMask = true
        datePickerToolTip.shouldDismissOnTap = false
        datePickerToolTip.bubbleColor = UIColor.systemGray6
        datePickerToolTip.bubbleOffset =  0.1
        datePickerToolTip.shouldDismissOnTapOutside = true
//        popTip.actionAnimation = .bounce(16.0)
        datepicker.datePickerMode = .date
        datepicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datepicker.frame.size = CGSize(width: 0, height: 300)
        datepicker.maximumDate = Date()

    }
    
    @objc func dateChange(datePicker: UIDatePicker)
    {
        
        date = formatDate(date: datePicker.date)
        time = formatTime(date: datePicker.date)
        
//        onClickListener?(formatDate(date: datePicker.date) )
//        datePickerToolTip.hide()
//        self.txtDOB.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
    
    func formatTime(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }
    
    
    func showPopTipTutorial(pointedView: UIView){
        if let topVC = UIApplication.getTopViewController()?.view {
//            popTipConfigurations()
            datePickerToolTip.show(customView: self, direction: .auto, in: topVC, from: pointedView.frame)
        }
    }
    
    func showDatePicker(pointedView: UIView, onClickListener : ((String)->Void)?){
        self.onClickListener = onClickListener
        self.datepicker.datePickerMode = .date
        self.showPopTipTutorial(pointedView: pointedView)

    }
    
    func showTimePicker(pointedView: UIView, onTimeClickListener : ((String)->Void)?){
        self.onTimeClickListener = onTimeClickListener
        self.datepicker.datePickerMode = .time
        self.showPopTipTutorial(pointedView: pointedView)

    }
    
    @IBAction func doneTapped(_ sender: Any) {
        
        onTimeClickListener?( time ?? "" )
        onClickListener?(date  ?? "" )
        datePickerToolTip.hide()
        
    }
    
    
}


extension DatePickerToolTip : UITableViewDataSource, UITableViewDelegate {
    
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
        datePickerToolTip.hide()
    }


}








