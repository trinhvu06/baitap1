//
//  SignUpViewController.swift
//  Project1
//
//  Created by Thanh Quach on 7/25/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD
import FirebaseAuth

class SignUpViewController: UIViewController {

    fileprivate let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "email"
        textField.keyboardType = .emailAddress
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()

    fileprivate let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.isSecureTextEntry = true
        return textField
    }()

    fileprivate let verifyPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Verify password"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.isSecureTextEntry = true
        return textField
    }()

    fileprivate let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.keyboardType = .default
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()

    fileprivate let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign-Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.setupConstraints()
    }

    fileprivate func setupView() {

        self.view.backgroundColor = .white

        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(verifyPasswordTextField)
        self.view.addSubview(nameTextField)
        self.view.addSubview(signUpButton)

        self.signUpButton.addTarget(self, action: #selector(self.didTapSignUpBtn(_:)), for: .touchUpInside)
    }

    fileprivate func setupConstraints() {

        let defaultInsetHorizontal = 40
        let defaultInsetVertical = 10

        self.emailTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(defaultInsetHorizontal)
            make.right.equalToSuperview().offset(-defaultInsetHorizontal)
            make.height.equalTo(34)
        }

        self.passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.emailTextField.snp.bottom).offset(defaultInsetVertical)
            make.left.right.height.equalTo(self.emailTextField)
        }

        self.verifyPasswordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(defaultInsetVertical)
            make.left.right.height.equalTo(self.emailTextField)
        }

        self.nameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.verifyPasswordTextField.snp.bottom).offset(defaultInsetVertical)
            make.left.right.height.equalTo(self.emailTextField)
        }

        self.signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameTextField.snp.bottom).offset(defaultInsetVertical)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }

    @objc fileprivate func didTapSignUpBtn(_ sender: Any) {
        guard let email = self.emailTextField.text,
            let password = self.passwordTextField.text,
            let verifyPassword = self.verifyPasswordTextField.text,
            let name = self.nameTextField.text else {
                SVProgressHUD.vu_showError("Bạn chưa nhập đẩy đủ dữ liệu vui lòng nhập đầy đủ")
                return
        }

        // Khong phai la email
        if !email.isEmail {
            SVProgressHUD.vu_showError("\(email) day khong phai la email ")
            return
        }

        if password != verifyPassword {
            SVProgressHUD.vu_showError("2 mau khau khong giong nhau")
            return
        }

        if password.count < 6 {
            SVProgressHUD.vu_showError("Password phai lon hon 6 ky tu")
            return
        }

        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            SVProgressHUD.dismiss()
            if let error = error {
                SVProgressHUD.vu_showError(error.localizedDescription)
                return
            }

            FIRManager.shared.userRef.child(result?.user.uid ?? "").setValue([
                "email": result?.user.email ?? "",
                "id": result?.user.uid ?? ""
                ])

            SVProgressHUD.vu_showSuccess("SignUp thanh cong", completion: {
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
}
