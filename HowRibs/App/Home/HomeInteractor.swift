//
//  HomeInteractor.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 8/28/25.
//

import RIBs
import RxSwift

protocol HomeRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToRandomColorView()
    
    func backToHome()
}

protocol HomePresentable: Presentable {
    var listener: HomePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol HomeListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    
    func didRequestLogin()
}

final class HomeInteractor: PresentableInteractor<HomePresentable>, HomeInteractable, HomePresentableListener {
   
    weak var router: HomeRouting?
    weak var listener: HomeListener?
    private let name: String

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: HomePresentable, name: String) {
        self.name = name
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
    
    func getName() -> String {
        return self.name
    }
    
    func goBackToLogin() {
        listener?.didRequestLogin()
    }
    
    func moveToRandomView() {
        router?.routeToRandomColorView()
    }
    
    func randomBack() {
        router?.backToHome()
    }
}
