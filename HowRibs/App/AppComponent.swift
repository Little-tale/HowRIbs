//
//  AppComponent.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 8/27/25.
//

import RIBs

class AppComponent: Component<EmptyComponent>, RootDependency {
    
    init() {
        super.init(dependency: EmptyComponent())
    }
}
