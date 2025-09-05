//
//  RootRouter.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 8/27/25.
//

import RIBs

protocol RootInteractable: Interactable, HomeListener, LoginListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func setRoot(_ vc: ViewControllable, animated: Bool)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
   
    private let loginBuilder: LoginBuildable
    private let homeBuilder: HomeBuildable
    
    private var currentChild: ViewableRouting?
    private var loginRouter: LoginRouting?
    private var homeRouter: HomeRouting?

    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         loginBuilder: LoginBuildable,
         homeBuilder: HomeBuildable) {
        self.loginBuilder = loginBuilder
        self.homeBuilder = homeBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        
        routToLogin()
    }

    func routToLogin() {
        if let child = currentChild {
            detachChild(child)
        }
        
        let login = loginBuilder.build(withListener: interactor)
        
        attachChild(login)
        currentChild = login
        loginRouter = login
        
        viewController.setRoot(login.viewControllable, animated: true)
    }
    
    func routToHome(name: String) {
        if let child = currentChild {
            detachChild(child)
        }
        
        let home = homeBuilder.build(withListener: interactor, name: name)
        
        attachChild(home)
        currentChild = home
        homeRouter = home
        
        viewController.setRoot(home.viewControllable, animated: true)
    }
}
