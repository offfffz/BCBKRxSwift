//
//  AuthenViewModel.swift
//  BCBKRxSwift
//
//  Created by offz on 11/22/15.
//  Copyright © 2015 offz. All rights reserved.
//

import Foundation
import RxSwift

class AuthenViewModel: NSObject {
    
    // Input
    let emailStream: Observable<String>
    let passwordStream: Observable<String>
    let loginTapped: Observable<Void>
    
    // Output
    var loginEnabled: Observable<Bool> {
        let emailValid = self.emailStream.map { $0.characters.count > 0 }
        let passwordValid = self.passwordStream.map { $0.characters.count > 8 }
        
        return combineLatest(passwordValid, emailValid) { $0 && $1 }
    }
    var loginState: Observable<Bool> {
        let loginFormData = combineLatest(emailStream, passwordStream){
            (email: $0, password: $1)
        }
        
        return loginTapped
            .withLatestFrom(loginFormData)
            .flatMap(login)
    }
    
    init(emailStream: Observable<String>,
        passwordStream: Observable<String>,
        loginTapped: Observable<Void>) {
            
        self.emailStream = emailStream
        self.passwordStream = passwordStream
        self.loginTapped = loginTapped
    }
    
    func login(email: String, password: String) -> Observable<Bool> {
        let loginSuccess = email == "test@test.com" && password == "1234567890"
        
        return just(loginSuccess)
    }
    
}
