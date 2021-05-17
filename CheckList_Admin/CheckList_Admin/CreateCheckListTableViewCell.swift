//
//  CreateCheckListTableViewCell.swift
//  CheckList_Admin
//
//  Created by Rizwan Ali on 28/04/2021.
//

import UIKit

protocol CreateCheckListTableViewCellDelegate: NSObjectProtocol {
    func callBackActionMarkPriority(index: Int)
    func callBackActionNotAvailable(index: Int)
}

class CreateCheckListTableViewCell: BaseTableViewCell {
    //MARK: - IBOUTLETS
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var btnPriority: UIButton!
    @IBOutlet weak var btnNotAvailable: UIButton!
    
    
    //MARK: - OBJECT AND VERIBALES
    weak var delegate: CreateCheckListTableViewCellDelegate?
    var index: Int = -1
    //MARK: - OVERRIDE METHODS
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - FUNCTIONS
    //func
    
    
    //MARK: - IBACTION METHODS
    @IBAction func actionPriority(_ sender: UIButton){
        if self.btnPriority.isSelected{
            self.btnPriority.isSelected = false
        }else{
            self.btnPriority.isSelected = true
        }
        delegate?.callBackActionMarkPriority(index: self.index)
    }
    
    @IBAction func actionNotAvailable(_ sender: UIButton){
        if self.btnNotAvailable.isSelected{
            self.btnNotAvailable.isSelected = false
        }else{
            self.btnNotAvailable.isSelected = true
        }
        delegate?.callBackActionNotAvailable(index: self.index)
    }
}
