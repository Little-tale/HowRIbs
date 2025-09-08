//
//  HomeBuilder.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 8/28/25.
//

import RIBs

protocol HomeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class HomeComponent: Component<HomeDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    
    let name: String
    
    init(dependency: HomeDependency, name: String) {
        self.name = name
        super.init(dependency: dependency)
    }
}

extension HomeComponent: RandomDependency {
    
}

// MARK: - Builder

protocol HomeBuildable: Buildable {
    func build(withListener listener: HomeListener, name: String) -> HomeRouting
}

final class HomeBuilder: Builder<HomeDependency>, HomeBuildable {

    override init(dependency: HomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: HomeListener, name: String) -> HomeRouting {
        let component = HomeComponent(dependency: dependency, name: name)
        let viewController = HomeViewController()
        let interactor = HomeInteractor(presenter: viewController, name: name)
        
        let randomBuilder = RandomBuilder(dependency: component)
        
        interactor.listener = listener
        return HomeRouter(interactor: interactor, viewController: viewController, randomColorBuilder: randomBuilder)
    }
}
