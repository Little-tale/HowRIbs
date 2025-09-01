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
}

final class HomeViewController: UIViewController, HomePresentable, HomeViewControllable {

    weak var listener: HomePresentableListener?
    /// Root -> Login -> Name Label
    private let nameLabel = UILabel().after {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .red
        setViewHierarchy()
        setUI()
        subscribe()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = listener?.getName()
    }
}

extension HomeViewController {
    
    private func setViewHierarchy() {
        view.addSubview(nameLabel)
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension HomeViewController {
    private func subscribe() {
        
    }
}
