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
    private let homeFlowBuilder: HomeFlowBuildable   // ✅ Flow 빌더 주입
    // private let homeBuilder: HomeBuildable          // ← Flow가 Home을 관리할 거면 생략 가능

    private var currentChild: Routing?               // ✅ ViewableRouting → Routing
    private var loginRouting: LoginRouting?          // (선택) 별도 추적
    private var homeFlowRouting: HomeFlowRouting?    // (선택) 별도 추적

    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        loginBuilder: LoginBuildable,
        homeFlowBuilder: HomeFlowBuildable          // ✅ Flow 주입
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

    // ✅ Home으로 직접 가지 않고 “HomeFlow”로 간다
    func routeToHome(name: String) {
        if let child = currentChild { detachChild(child); currentChild = nil }
        
        let flow = homeFlowBuilder.build(withListener: interactor)

        attachChild(flow)
        currentChild = flow
        homeFlowRouting = flow
    }
}
