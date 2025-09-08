//
//  HomeViewController.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 8/28/25.
//

import RIBs
import RxSwift
import UIKit

protocol HomePresentableListener: AnyObject {
    func getName() -> String
    
    func goBackToLogin()
    
    func moveToRandomView()
}

final class HomeViewController: UIViewController, HomePresentable, HomeViewControllable {

    weak var listener: HomePresentableListener?
    /// Root -> Login -> Name Label
    private let nameLabel = UILabel().after {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let backLoginButton = UIButton().after {
        $0.setTitle("Go Back", for: .normal)
        $0.setTitleColor(.red, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let randomColorMoveButton = UIButton().after {
        $0.setTitle("NEXT", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .blue
        setViewHierarchy()
        setUI()
        subscribe()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = listener?.getName()
    }
    
    func pushViewController(_ viewController: ViewControllable) {
        self.navigationController?.pushViewController(viewController.uiviewController, animated: true)
    }
    
    func popViewController(animated: Bool) {
        self.navigationController?.popViewController(animated: animated)
    }
}

extension HomeViewController {
    
    private func setViewHierarchy() {
        view.addSubview(nameLabel)
        view.addSubview(backLoginButton)
        view.addSubview(randomColorMoveButton)
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            backLoginButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            backLoginButton.widthAnchor.constraint(equalToConstant: 120),
            backLoginButton.heightAnchor.constraint(equalToConstant: 40),
            
            randomColorMoveButton.topAnchor.constraint(equalTo: backLoginButton.bottomAnchor, constant: 10),
            randomColorMoveButton.centerXAnchor.constraint(equalTo: backLoginButton.centerXAnchor)
        ])
    }
}

extension HomeViewController {
    private func subscribe() {
        backLoginButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.listener?.goBackToLogin()
            }
            .disposed(by: rx.disposeBag)
        
        randomColorMoveButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.listener?.moveToRandomView()
            }
            .disposed(by: rx.disposeBag)
    }
}
