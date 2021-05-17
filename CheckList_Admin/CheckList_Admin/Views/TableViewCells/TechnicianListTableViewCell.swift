//
//  TechnicianListTableViewCell.swift
//  CheckList_Admin
//
//  Created by Rizwan Ali on 06/05/2021.
//

import UIKit

protocol TechnicianListTableViewCellDelegate: NSObjectProtocol {
    func callBackActionEditTechnician(index: Int)
    func callBackActionDeleteTechnician(index: Int)
}

class TechnicianListTableViewCell: BaseTableViewCell {
    //MARK: - IBOUTLETS
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var imgImage: UIImageView!
    
    //MARK: - OBJECT AND VERIBALES
    weak var delegate: TechnicianListTableViewCellDelegate?
    var index: Int = -1
    
    //MARK: - OVERRIDE METHODS
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //MARK: - FUNCTIONS
    func configureTechnician(info: AdminViewModel, indexP: Int){
        self.lblFullName.text = info.firstName + " " + info.lastName
        self.lblEmail.text = info.email
        self.setImageWithUrl(imageView: self.imgImage, url: info.image, placeholder: AssetNames.Box_Blue)
        self.index = indexP
    }
    
    //MARK: - IBACTION METHODS
    @IBAction func actionEdit(_ sender: UIButton){
        delegate?.callBackActionEditTechnician(index: self.index)
    }
    
    @IBAction func actionDelete(_ sender: UIButton){
        delegate?.callBackActionDeleteTechnician(index: self.index)
    }
}
