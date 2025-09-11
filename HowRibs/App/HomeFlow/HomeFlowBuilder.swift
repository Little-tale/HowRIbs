//
//  HomeFlowBuilder.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 9/11/25.
//

import RIBs

protocol HomeFlowDependency: Dependency {
    var rootVC: RootViewControllable { get }
    var homeBuilder: HomeBuildable { get }
    var randomBuilder: RandomBuildable { get }
}

final class HomeFlowComponent: Component<HomeFlowDependency> {
    
}

// MARK: - Builder
protocol HomeFlowBuildable: Buildable {
    func build(withListener listener: HomeFlowListener) -> HomeFlowRouting
}

final class HomeFlowBuilder: Builder<HomeFlowDependency>, HomeFlowBuildable {

    override init(dependency: HomeFlowDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: HomeFlowListener) -> HomeFlowRouting {
        let component = HomeFlowComponent(dependency: dependency)
        let interactor = HomeFlowInteractor()
        interactor.listener = listener
        
//        return HomeFlowRouter(interactor: interactor, viewController: component.HomeFlowViewController)
        return HomeFlowRouter(interactor: interactor, rootVc: dependency.rootVC, homeBuilder: dependency.homeBuilder, randomColorBuilder: dependency.randomBuilder)
    }
}
