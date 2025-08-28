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
}

extension RootComponent: HomeDependency {
    
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
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController)
        
        
        // MARK: Home
        let homeBuild = HomeBuilder(dependency: component)
        
        return RootRouter(interactor: interactor, viewController: viewController, homeBuilder: homeBuild)
    }
}
