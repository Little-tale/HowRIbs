//
//  RootRouter.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 8/27/25.
//

import RIBs

protocol RootInteractable: Interactable, HomeListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
   
    private let homeBuilder: HomeBuildable

    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        homeBuilder: HomeBuildable
    ){
        self.homeBuilder = homeBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func login(name: String) {
        let build = homeBuilder.build(withListener: interactor, name: name)
        attachChild(build)
    }
    
    func routeToHome() {
        
    }
}
