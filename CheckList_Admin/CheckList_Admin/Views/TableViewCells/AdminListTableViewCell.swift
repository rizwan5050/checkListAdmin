//
//  AdminListTableViewCell.swift
//  CheckList_Admin
//
//  Created by Rizwan Ali on 28/04/2021.
//

import UIKit

protocol AdminListTableViewCellDelegate: NSObjectProtocol {
    func callBackActionEditAdmin(index: Int)
    func callBackActionDeleteAdmin(index: Int)
}

class AdminListTableViewCell: BaseTableViewCell {
    //MARK: - IBOUTLETS
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var imgImage: UIImageView!
    
    //MARK: - OBJECT AND VERIBALES
    weak var delegate: AdminListTableViewCellDelegate?
    var index: Int = -1
    
    //MARK: - OVERRIDE METHODS
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //MARK: - FUNCTIONS
    func configureAdmin(info: AdminViewModel, indexPath: Int){
        self.lblFullName.text = info.firstName + " " + info.lastName
        self.lblEmail.text = info.email
        self.setImageWithUrl(imageView: self.imgImage, url: info.image, placeholder: AssetNames.Box_Blue)
        self.index = indexPath
    }
    
    //MARK: - IBACTION METHODS
    @IBAction func actionEdit(_ sender: UIButton){
        delegate?.callBackActionEditAdmin(index: self.index)
    }
    
    @IBAction func actionDelete(_ sender: UIButton){
        delegate?.callBackActionDeleteAdmin(index: self.index)
    }
}
