//
//  RandomViewController.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 9/8/25.
//

import RIBs
import RxSwift
import UIKit

protocol RandomPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    func didTapBackButton()
}

final class RandomViewController: UIViewController, RandomPresentable, RandomViewControllable {

    weak var listener: RandomPresentableListener?
    
    private let baseView = RandomView()
    
    override func loadView() {
        super.loadView()
        self.view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSubscribe()
    }
    
}

// MARK: UIEVENT SUBSCRIBE
extension RandomViewController {
    
    private func viewSubscribe() {
        baseView.viewEventStream
            .bind(with: self) { owner, events in
                switch events {
                case .colorChange:
                    print("ASDAA")
                    owner.baseView.backgroundColor = .random
                case .backButtonTapped:
                    owner.listener?.didTapBackButton()
                }
            }
            .disposed(by: rx.disposeBag)
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    RandomViewController()
}
#endif

