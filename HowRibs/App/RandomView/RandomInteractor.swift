//
//  RandomInteractor.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 9/8/25.
//

import RIBs
import RxSwift

protocol RandomRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RandomPresentable: Presentable {
    var listener: RandomPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RandomListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func randomBack()
}

final class RandomInteractor: PresentableInteractor<RandomPresentable>, RandomInteractable, RandomPresentableListener {

    weak var router: RandomRouting?
    weak var listener: RandomListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RandomPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTapBackButton() {
        listener?.randomBack()
    }
}
