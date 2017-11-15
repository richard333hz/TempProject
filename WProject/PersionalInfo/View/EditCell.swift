//
//  EditCell.swift
//  XianMuShu
//
//  Created by Weiwei on 2017/11/10.
//  Copyright © 2017年 pandaApe. All rights reserved.
//

import UIKit

class EditCellModel: NSObject {
    
    var title = String()
    var unit = String()
    var type = EditCellType.input
    var dataArr = [String]()
}

enum EditCellType {
    case input
    case selectNormal
    case selectTime
}

class EditCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var rightArrowImgView: UIImageView!
    
    var model = EditCellModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setView(model: EditCellModel) {
        
        self.model = model
        
        self.titleLable.text = model.title
        
        if model.unit.count > 0 {
            self.unitLabel.isHidden = false
            self.rightArrowImgView.isHidden = true
            self.unitLabel.text = model.unit
        }
        else {
            self.unitLabel.isHidden = true
            self.rightArrowImgView.isHidden = false
            
            self.textField.delegate = self
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.superview?.endEditing(true)
        
        if self.model.type == .selectNormal {
            let normalPicker = WPicker.creatPicker(type: .normal, dataArr: model.dataArr)
            
            normalPicker.ensureBtnClickedNormalClosure = { [weak self] index in
                
                self?.textField.text = self?.model.dataArr[index]
            }
        }
        else if self.model.type == .selectTime {
            
            let timePicker = WPicker.creatPicker(type: .time)
            
            timePicker.ensureBtnClickedTimeClosure = { [weak self] dateStr in
                
                self?.textField.text = dateStr
            }
        }
        
        return false
    }
}