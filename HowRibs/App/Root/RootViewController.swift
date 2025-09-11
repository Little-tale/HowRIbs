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
    private weak var current: UINavigationController?
    
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
        let rootVC = vc.uiviewController
        let nav = UINavigationController()
        nav.setViewControllers([rootVC], animated: false) // 초기 세팅은 false 권장
        
        // 기존 제거
        if let current {
            current.willMove(toParent: nil)
            current.view.removeFromSuperview()
            current.removeFromParent()
        }
        
        addChild(nav)
        container.addSubview(nav.view)
        nav.view.frame = container.bounds
        nav.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        nav.didMove(toParent: self)
        current = nav
        
        // 페이드 인
        if animated {
            container.alpha = 0
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.container.alpha = 1
            }
        }
    }
    
    func push(_ vc: ViewControllable, animated: Bool) {
        current?.navigationController?.pushViewController(vc.uiviewController, animated: animated)
    }
    
    func pop(animated: Bool) {
        current?.navigationController?.popViewController(animated: animated)
    }
}
