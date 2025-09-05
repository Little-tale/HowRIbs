//
//  LoginViewController.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 9/5/25.
//

import RIBs
import RxSwift
import UIKit

protocol LoginPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    func touchToLogin(name: String)
}

final class LoginViewController: UIViewController, LoginPresentable, LoginViewControllable {
    
    private let baseView = LoginView()
    
    override func loadView() {
        super.loadView()
        self.view = baseView
        subscribe()
    }

    weak var listener: LoginPresentableListener?
}

extension LoginViewController {
    
    private func subscribe() {
        baseView.button.rx.tap
            .bind(with: self) { owner, _ in
                owner.listener?.touchToLogin(name: "테스트를 위함")
            }
            .disposed(by: rx.disposeBag)
    }
}
