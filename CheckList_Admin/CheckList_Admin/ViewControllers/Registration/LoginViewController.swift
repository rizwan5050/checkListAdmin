//
//  LoginViewController.swift
//  CheckList_Admin
//
//  Created by Rizwan Ali on 29/04/2021.
//

import UIKit

class LoginViewController: BaseViewController {
    //MARK: - IBOUTLETS
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPassword: UIView!
    
    //MARK: - OBJECT AND VERIBALES
    
    
    //MARK: - OVERRIDE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewEmail.dropShadow(radius: 5, opacity: 0.4)
        self.viewPassword.dropShadow(radius: 5, opacity: 0.4)
        #if DEBUG
        self.txtEmail.text = "testAdmin12@gmail.com"
        self.txtPassword.text = "12345678"
        #endif
       
    }
    
    //MARK: - IBACTION METHODS
    @IBAction func actionLogin(_ sender: UIButton){
        if self.checkValidations(){
            self.doLoginApi(params: [DictKeys.email: self.txtEmail.text!,
                                     DictKeys.password: self.txtPassword.text!])
        }
    }
    
    @IBAction func actionForgotPassword(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.ForgotPasswordViewController) as! ForgotPasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - FUNCTIONS
    func checkValidations() -> Bool{
        var isValid: Bool = true
        let validEmail = Validations.emailValidation(self.txtEmail.text!)
        let validPassword = Validations.passwordValidation(self.txtPassword.text!)
        if !validEmail.isValid{
            self.showAlertView(message: validEmail.message)
            isValid = false
        }else if !validPassword.isValid{
            self.showAlertView(message: validPassword.message)
            isValid = false
        }
        return isValid
    }
    
    func nevigateToMain(){
        let storyboard = UIStoryboard(name: StoryboardNames.Main, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ControllerIdentifier.SWRevealViewController) as! SWRevealViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - API CALL
    func doLoginApi(params: ParamsAny){
        self.startActivity()
        GCD.async(.Background) {
            LoginService.shared().loginApiCall(params: params) { (message, success, info) in
                GCD.async(.Main) {
                    self.stopActivity()
                    if success{
                        self.nevigateToMain()
                    }else{
                        self.showAlertView(message: message)
                    }
                }
            }
        }
    }
}
