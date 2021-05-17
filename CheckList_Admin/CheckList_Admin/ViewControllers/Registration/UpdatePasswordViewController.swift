//
//  UpdatePasswordViewController.swift
//  CheckList_Admin
//
//  Created by Rizwan Ali on 11/05/2021.
//

import UIKit

class UpdatePasswordViewController: BaseViewController {
    //MARK: - IBOUTLETS
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPinCode: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    
    //MARK: - OBJECT AND VERIBAELS
    
    
    
    //MARK: - OVERRIDE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - IBACTION METHODS
    @IBAction func actionSave(_ sender: UIButton){
        let params: ParamsAny = [DictKeys.email: self.txtEmail.text!,
                                 DictKeys.Pin_Code: self.txtPinCode.text!,
                                 DictKeys.New_Password: self.txtNewPassword.text!,
                                 DictKeys.login_type: "admin"]
        self.updatePasswordApiCall(Params: params)
    }
    
    
    //MARK: - FUNCTIONS
    func checkValidations() -> Bool{
        var isValid: Bool = true
        let validEmail = Validations.emailValidation(self.txtEmail.text!)
        let validPassword = Validations.passwordValidation(self.txtNewPassword.text!)
        
        if !validEmail.isValid{
            self.showAlertView(message: validEmail.message)
            isValid = false
        }else if !validPassword.isValid{
            self.showAlertView(message: validPassword.message)
            isValid = false
        }else if self.txtPinCode.text!.isEmpty{
            self.showAlertView(message: ValidationMessages.emptyPincode)
            isValid = false
        }
        return isValid
    }
    
}
//MARK: - EXTENSION API CALLS
extension UpdatePasswordViewController{
    func updatePasswordApiCall(Params: ParamsAny){
        self.startActivity()
        GCD.async(.Background) {
            LoginService.shared().updatePasswordApi(params: Params) { (message, success) in
                GCD.async(.Main) {
                    self.stopActivity()
                    
                    if success{
                        self.showAlertView(message: message, title: "", doneButtonTitle: "Ok") { (UIAlertAction) in
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                        
                    }else{
                        self.showAlertView(message: message)
                    }
                }
            }
        }
    }
}
