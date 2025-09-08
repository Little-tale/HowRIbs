//
//  RandomRouter.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 9/8/25.
//

import RIBs

protocol RandomInteractable: Interactable {
    var router: RandomRouting? { get set }
    var listener: RandomListener? { get set }
}

protocol RandomViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RandomRouter: ViewableRouter<RandomInteractable, RandomViewControllable>, RandomRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: RandomInteractable, viewController: RandomViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
