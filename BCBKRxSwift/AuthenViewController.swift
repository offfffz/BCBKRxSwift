//
//  AuthenViewController.swift
//  BCBKRxSwift
//
//  Created by offz on 11/22/15.
//  Copyright © 2015 offz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AuthenViewController: UITableViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel: AuthenViewModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        let emailStream = emailField.rx_text.asObservable()
        let passwordStream = passwordField.rx_text.asObservable()
        let loginTapped = loginButton.rx_tap.asObservable()
        
        viewModel = AuthenViewModel(emailStream: emailStream,
            passwordStream: passwordStream,
            loginTapped: loginTapped)
        
        viewModel?.loginEnabled
            .observeOn(MainScheduler.sharedInstance)
            .bindTo(loginButton.rx_enabled)
            .addDisposableTo(disposeBag)
        
        viewModel?.loginState
            .subscribeNext { [unowned self] in
                self.showAlertFor(loginSuccess: $0)
            }.addDisposableTo(disposeBag)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func showAlertFor(loginSuccess loginSuccess: Bool) {
        var alertController: UIAlertController
        if loginSuccess {
            alertController = self.alertFor("Login Success!")
        } else {
            alertController = self.alertFor("Wrong email or password")
        }
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func alertFor(title: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        
        alertController.addAction(okAction)
        
        return alertController
    }

}
