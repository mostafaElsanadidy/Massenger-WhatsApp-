//
//  ViewController.swift
//  Massenger
//
//  Created by Mustafa Elsanadidy on 07/10/2021.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK: - IBOutlet
    //Labels
    @IBOutlet weak var emailLabelOutlet: UILabel!
    @IBOutlet weak var passwordLabelOutlet: UILabel!
    @IBOutlet weak var repeatPasswordLabel: UILabel!
    @IBOutlet weak var signUpLabel: UILabel!
    //textFields
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    //Buttons
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var signUpButtonOutlet: UIButton!
    @IBOutlet weak var resendEmailButtonOutlet: UIButton!
    //Views
    @IBOutlet weak var repeatPasswordLineView: UIView!
    
    //MARK: - Vars
    var isLogin = true
    
    enum DataInputStatus{
        case login
        case register
        case forgotPassword
        case resendEmail
    }
    
    //MARK: - View lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
        setupTextFieldDelegates()
        updateUIFor(login: isLogin)
        isLogin.toggle()
    }
    
    //MARK: - IBActions
       
       @IBAction func loginButtonPressed(_ sender: UIButton) {
        if isDataInutedFor(type: isLogin ? .login : .register){
            //login or register
            print("have data for login/reg")
        }else{
//            progressHUD.showFailed("All Fields are required")
        }
       }
    
       @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
        if isDataInutedFor(type: .forgotPassword){
            //reset password
            print("have data for forgot password")
        }else{
//            progressHUD.showFailed("Email are required")
        }
       }
    
       @IBAction func resendEmailButtonPressed(_ sender: UIButton) {
        if isDataInutedFor(type: .resendEmail){
            //resend verification email
            print("have data for resend email")
        }else{
//            progressHUD.showFailed("Email are required")
        }
       }
    
       @IBAction func signUpButtonPressed(_ sender: UIButton) {
        updateUIFor(login: isLogin)
        isLogin.toggle()
       }
    
    //MARK: - Setup
    func setupTextFieldDelegates() {
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_: )), for: .editingChanged)
   //     passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_: )), for: .editingChanged)
        repeatPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_: )), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField:UITextField) {
        updatePlaceholderLabels(textField: textField)
    }
    
    private func setupBackgroundTap(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func backgroundTap() {
        view.endEditing(false)
    }
    
    //MARK: - Animation
    private func updatePlaceholderLabels(textField:UITextField){
        switch textField {
        case emailTextField:
            emailLabelOutlet.text = textField.hasText ? "Email" : ""
        case passwordTextField:
            passwordLabelOutlet.text = textField.hasText ? "Password" : ""
        default:
            repeatPasswordLabel.text = textField.hasText ? "Repeat Password" : ""
        }
    }
    
    private func updateUIFor(login:Bool){
        
       // loginButtonOutlet.setImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
        signUpLabel.text = login ? "Don't have an account?" : "Have an account?"
        signUpButtonOutlet.setTitle(login ? "SignUp" : "Login" , for: .normal)
        UIView.animate(withDuration: 0.5) {
            self.repeatPasswordLabel.isHidden = login
            self.repeatPasswordTextField.isHidden = login
            self.repeatPasswordLineView.isHidden = login
        }
    }
//MARK: - Helpers
    private func isDataInutedFor(type:DataInputStatus) -> Bool {
        switch type {
        case .login:
            return emailTextField.hasText && passwordTextField.hasText
        case .register:
            return emailTextField.hasText && passwordTextField.hasText && repeatPasswordTextField.hasText
        default:
            return emailTextField.hasText
        }
    }
    
}

