//
//  LoginViewController.swift
//  PostsApp
//
//  Created by Preetham Baliga on 11/09/23.
//

import UIKit

class LoginViewController: UIViewController, Storyboarded {

    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    var onLogin: ((Int) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isEnabled = false
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        userIdTextField.resignFirstResponder()
        if let enteredId = userIdTextField.text, let userId = Int(enteredId) {
            onLogin?(userId)
        }
    }

    deinit {
        print("Login VC deinit")
    }
}

extension LoginViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        loginButton.isEnabled = !newText.isEmpty
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        loginButton.isEnabled = false
        return true
    }
}
