//
//  RandomBuilder.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 9/8/25.
//

import RIBs

protocol RandomDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RandomComponent: Component<RandomDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RandomBuildable: Buildable {
    func build(withListener listener: RandomListener) -> RandomRouting
}

final class RandomBuilder: Builder<RandomDependency>, RandomBuildable {

    override init(dependency: RandomDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RandomListener) -> RandomRouting {
        let component = RandomComponent(dependency: dependency)
        let viewController = RandomViewController()
        let interactor = RandomInteractor(presenter: viewController)
        interactor.listener = listener
        return RandomRouter(interactor: interactor, viewController: viewController)
    }
}
