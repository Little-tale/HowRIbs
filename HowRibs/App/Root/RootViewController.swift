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
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
    
    private let container = UIView()
    private weak var current: UIViewController?
    
    weak var listener: RootPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = container
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func setRoot(_ vc: ViewControllable, animated: Bool) {
        let vc = vc.uiviewController
        
        if let current {
            current.willMove(toParent: nil)
            current.view.removeFromSuperview()
            current.removeFromParent()
        }
        
        addChild(vc)
        vc.view.frame = container.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        container.addSubview(vc.view)
        vc.didMove(toParent: self)
        current = vc
        
        if animated {
            container.alpha = 0
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self else { return }
                container.alpha = 1
            }
        }
    }
}
