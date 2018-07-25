//
//  ViewController.swift
//  Project1
//
//  Created by trinh truong vu on 7/16/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit

class ViewController: UIViewController {
    fileprivate let emailTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.placeholder = "Nhập Email"
        return textField
    }()
    
    fileprivate let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "Nhập Mật Khẩu"
        return textField
    }()

    fileprivate let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign-Up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    fileprivate let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign-in", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    fileprivate let ggsignInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Google-SignIn", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    fileprivate let fbsignInButton: UIButton = {
        let button = UIButton()
        button.setTitle("FaceBook-SignIn", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setupConstraints()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        if let user = UserManager.share.getCurrenUser(){
            print(user)
        }
       
    }

    fileprivate func setupView() {
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(signInButton)
        self.view.addSubview(ggsignInButton)
        self.view.addSubview(fbsignInButton)
        self.view.addSubview(signUpButton)
        
        self.signInButton.addTarget(self, action: #selector(self.didTapInSignButton(_:)), for: .touchUpInside)
        self.ggsignInButton.addTarget(self, action: #selector(self.didTapGoogleSignInBtn(_:)), for: .touchUpInside)
        self.fbsignInButton.addTarget(self, action: #selector(self.didTapFaceBookSignInBtn(_:)), for: .touchUpInside)
        self.signUpButton.addTarget(self, action: #selector(self.didTapSignUpButton(_:)), for: .touchUpInside)
    }

    fileprivate func setupConstraints() {
        
        self.emailTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        self.passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.emailTextField.snp.bottom).offset(10)
            make.left.right.equalTo(self.emailTextField)
        }
        
        self.signInButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
        }
        self.ggsignInButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(signInButton.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
        
        self.fbsignInButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(ggsignInButton.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }

        self.signUpButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(fbsignInButton.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
    }

    @objc fileprivate func didTapSignUpButton(_ sender: Any!) {
        let signUpViewController = SignUpViewController()
        self.present(signUpViewController, animated: true, completion: nil)
    }

    @objc fileprivate func didTapInSignButton(_ sender: Any!){
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            if let error = error {
                
                print(error.localizedDescription)
                
                return
            }
            print(result?.user)
            print(result?.additionalUserInfo)
        }
//        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
//            if let error = error {
//               
//                print(error.localizedDescription)
//                
//                return
//            }
//            print(result?.user)
//            print(result?.additionalUserInfo)
//        }
    }

    @objc fileprivate func didTapGoogleSignInBtn(_ sender: Any!) {
       GIDSignIn.sharedInstance().signIn()
    }

    @objc fileprivate func didTapFaceBookSignInBtn(_ sender: Any!) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in

            guard error == nil,
                let fbloginresult = result,
                fbloginresult.isCancelled == false,
                fbloginresult.grantedPermissions.contains("email")
            else {
                return
            }

            self.getFBUserData()
            // Login with firebase here
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    // ...
                    return
                }
                print(authResult?.user)
                print(authResult?.additionalUserInfo)
                print(authResult?.additionalUserInfo?.profile)
            }
        }
    }
    
    func getFBUserData(){
        guard let _ = FBSDKAccessToken.current() else {
            return
        }

        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
            if (error == nil){
                //everything works print the user data
                print(result)
            }
        })
    }
    
}
extension ViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                return
            }
            print(authResult?.user)
            print(authResult?.additionalUserInfo)
            print(authResult?.additionalUserInfo?.profile)
        }
    }
    
}

