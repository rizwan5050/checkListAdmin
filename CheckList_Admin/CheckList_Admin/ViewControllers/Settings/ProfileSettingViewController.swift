//
//  SettingViewController.swift
//  CheckList_Admin
//
//  Created by Rizwan Ali on 06/05/2021.
//

import UIKit

class ProfileSettingViewController: BaseViewController, TopBarDelegate {
    //MARK: - IBOUTLETS
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    //MARK: - OVERRIDE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewShadow.dropShadow(radius: 5, opacity: 0.4)
        self.configureUserInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let container = self.mainContainer{
            container.delegate = self
            container.setMenuButton(true, title: TitleNames.Setting)
        }
    }
    
    //MARK: - IBACTION METHODS
    @IBAction func actionChangePassword(_ sender: UIButton){
        self.showChangePasswordPopUP()
        self.alertView?.show()
    }
    
    @IBAction func actionChoosePhoto(_ sender:UIButton){
        self.fetchProfileImage()
    }
    
    @IBAction func actionSave(_ sender:UIButton){
        
    }
    
    //MARK: - FUNCTIONS
    func actionBack() {
        self.loadHomeController()
    }
    func configureUserInfo(){
        if let info = Global.shared.user{
            self.txtName.text = info.firstName + " " + info.lastName
            self.txtEmail.text = info.email
            self.txtPhone.text = info.phoneNumber
        }
    }
    
    //MARK: - CHANGE PASSWORD DELEGATE METHODS
    override func callBackActionSubmit(_ currentPassword: String, _ newPassword: String) {
        self.changePasswordApiCall(Params: [DictKeys.Current_Password: currentPassword,
                                            DictKeys.New_Password: newPassword])
    }
    
    override func callBackActionClosePopup() {
        self.alertView?.close()
    }
    
    
    //MARK: - IMAGE PICKER CONTROLLER DELEGATE METHODS
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.imgProfile.image = image
        picker.dismiss(animated: true, completion: nil)
    }
}


//MARK: - EXTENSION API CALLS
extension ProfileSettingViewController{
    func changePasswordApiCall(Params: ParamsAny){
        self.startActivity()
        GCD.async(.Background) {
            LoginService.shared().changePasswordApi(params: Params) { (message, success) in
                GCD.async(.Main) {
                    self.stopActivity()
                    
                    if success{
                        self.showAlertView(message: message, title: "", doneButtonTitle: "Ok") { (UIAlertAction) in
                            self.alertView?.close()
                        }
                        
                    }else{
                        self.showAlertView(message: message)
                    }
                }
            }
        }
    }
}

