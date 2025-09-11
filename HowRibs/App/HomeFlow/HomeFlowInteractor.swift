//
//  HomeFlowInteractor.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 9/11/25.
//

import RIBs
import RxSwift

protocol HomeFlowRouting: Routing {
    func start(name: String)
    func routeToRandomColor()
    func routeBackToHome()
}

protocol HomeFlowListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    
    func moveToLogin()
}

final class HomeFlowInteractor: Interactor, HomeFlowInteractable {

    weak var router: HomeFlowRouting?
    weak var listener: HomeFlowListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init() {}

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
    }
}

extension HomeFlowInteractor: HomeListener {
    func didRequestLogin() {
        listener?.moveToLogin()
    }
}

extension HomeFlowInteractor: RandomListener {
    func randomBack() {
        router?.routeToRandomColor()
    }
}
