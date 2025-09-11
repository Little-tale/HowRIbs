//
//  HomeFlowRouter.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 9/11/25.
//

import RIBs

protocol HomeFlowInteractable: Interactable, HomeListener, RandomListener {
    var router: HomeFlowRouting? { get set }
    var listener: HomeFlowListener? { get set }
}

final class HomeFlowRouter: Router<HomeFlowInteractable>, HomeFlowRouting {

    // MARK: - Private
    private let rootVc: RootViewControllable
    private let homeBuilder: HomeBuildable
    private let randomColorBuilder: RandomBuildable
    
    private var homeRouting: HomeRouting?
    private var randomColorRouting: RandomRouting?
    
    init(interactor: HomeFlowInteractable, rootVc: RootViewControllable, homeBuilder: HomeBuildable, randomColorBuilder: RandomBuildable, homeRouting: HomeRouting? = nil, randomColorRouting: RandomRouting? = nil) {
        self.rootVc = rootVc
        self.homeBuilder = homeBuilder
        self.randomColorBuilder = randomColorBuilder
        self.homeRouting = homeRouting
        self.randomColorRouting = randomColorRouting
        super.init(interactor: interactor)
        interactor.router = self
    }
    
    func start(name: String) {
        let home = homeBuilder.build(withListener: interactor, name: name)
        attachChild(home)
        
        homeRouting = home
        rootVc.setRoot(home.viewControllable, animated: false)
    }
    
    func routeToRandomColor() {
        guard homeRouting != nil else { return }
        let random = randomColorBuilder.build(withListener: interactor)
        attachChild(random)
        randomColorRouting = random
        rootVc.push(random.viewControllable, animated: true)
    }
    
    func routeBackToHome() {
        guard let random = self.randomColorRouting else { return }
        rootVc.pop(animated: true)
        detachChild(random)
        randomColorRouting = nil
    }
    
}

