//
//  RootBuilder.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 8/27/25.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    
    private let rootVc: RootViewController
    
    init(dependency: RootDependency, rootVc: RootViewController) {
        self.rootVc = rootVc
        super.init(dependency: dependency)
    }
}

extension RootComponent: LoginDependency {
    
}

extension RootComponent: HomeFlowDependency, HomeDependency, RandomDependency {
    
    var rootVC: RootViewControllable {
        return rootVc
    }
    
    var homeBuilder: HomeBuildable {
        HomeBuilder(dependency: self)
    }
    
    var randomBuilder: RandomBuildable {
        RandomBuilder(dependency: self)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let viewController = RootViewController()
        let component = RootComponent(dependency: dependency, rootVc: viewController)
        
        let interactor = RootInteractor(presenter: viewController)
        
        let loginBuilder    = LoginBuilder(dependency: component)
        let homeFlowBuilder = HomeFlowBuilder(dependency: component)
        
        return RootRouter(
            interactor: interactor,
            viewController: viewController,
            loginBuilder: loginBuilder,
            homeFlowBuilder: homeFlowBuilder
        )
    }
}
