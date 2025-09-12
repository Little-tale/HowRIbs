//
//  RootRouter.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 8/27/25.
//

import RIBs

protocol RootInteractable: Interactable, LoginListener, HomeFlowListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func setRoot(_ vc: ViewControllable, animated: Bool)
    
    func push(_ vc: ViewControllable, animated: Bool)
    
    func pop(animated: Bool)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    private let loginBuilder: LoginBuildable
    private let homeFlowBuilder: HomeFlowBuildable
    // private let homeBuilder: HomeBuildable

    private var currentChild: Routing?
    private var loginRouting: LoginRouting?
    private var homeFlowRouting: HomeFlowRouting?

    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        loginBuilder: LoginBuildable,
        homeFlowBuilder: HomeFlowBuildable
    ) {
        self.loginBuilder = loginBuilder
        self.homeFlowBuilder = homeFlowBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()
        routeToLogin()
    }

    func routeToLogin() {
        if let child = currentChild { detachChild(child); currentChild = nil }
        let login = loginBuilder.build(withListener: interactor)
        attachChild(login)
        currentChild = login
        loginRouting = login
        viewController.setRoot(login.viewControllable, animated: true)
    }

   
    func routeToHome(name: String) {
        let old = currentChild
        let flow = homeFlowBuilder.build(withListener: interactor)
        
        attachChild(flow)
        currentChild = flow
        homeFlowRouting = flow
        
        flow.start(name: name)
        
        if let old { detachChild(old) }
    }
}
