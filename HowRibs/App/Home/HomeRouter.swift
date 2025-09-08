//
//  HomeRouter.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 8/28/25.
//

import RIBs

protocol HomeInteractable: Interactable, RandomListener {
    var router: HomeRouting? { get set }
    var listener: HomeListener? { get set }
}

protocol HomeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func pushViewController(_ viewController: ViewControllable)
    
    func popViewController(animated: Bool)
}

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>, HomeRouting {

    private let randomColorBuilder: RandomBuilder
    private var randomRouting: RandomRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: HomeInteractable,
         viewController: HomeViewControllable,
         randomColorBuilder: RandomBuilder
    ) {
        self.randomColorBuilder = randomColorBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToRandomColorView() {
        let child = randomColorBuilder.build(withListener: interactor)
        attachChild(child)
        self.randomRouting = child
        viewController.pushViewController(child.viewControllable)
    }
    
    func backToHome() {
        guard let child = randomRouting else { return }
        viewController.popViewController(animated: true)
        detachChild(child)
        randomRouting = nil
    }
}
