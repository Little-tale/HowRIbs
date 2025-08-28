//
//  RootViewController.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 8/27/25.
//

import RIBs
import RxCocoa
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    func tryLogin()
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?
    
    // 시작 버튼
    private let button = UIButton().after {
        var config = UIButton.Configuration.filled()
        config.title = "로그인"
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)
        $0.configuration = config
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(button)
        
    
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        button.rx.tap
            .bind(with: self) { owner, _ in
                owner.listener?.tryLogin()
            }
            .disposed(by: rx.disposeBag)
    }
    
    func present(vc: ViewControllable) {
        self.present(vc.uiviewController, animated: true, completion: nil)
    }
}
