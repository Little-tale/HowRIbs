//
//  HomeFlowRouter.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 9/11/25.
//

import RIBs

/*
 Why Home Flow?
 
 👀 Flow를 끼는 이유
 
 이전 까진 Root -> Home 의 구조였는데
 사이에 Flow를 끼움으로써
 
 Home 화면의 역활은 UI 입력 처리
 Flow는 Home 의 화면전환을 관리하는 Attach/Detach 담당하게 되는 구조
 
 즉 책임을 또 분리 함으로써 단일책임을 확고
 
 TCA편에서 구조화 하였듯 각 TabBar 의 코디네이션을 분리하듯이 이도 그런 구조를 취함
 
 다만 단일 화면에서는 필요가 없음
 */

protocol HomeFlowInteractable: Interactable, HomeListener, RandomListener {
    var router: HomeFlowRouting? { get set }
    var listener: HomeFlowListener? { get set }
}

final class HomeFlowRouter: Router<HomeFlowInteractable>, HomeFlowRouting {

    // MARK: - Private
    private let rootVc: RootViewControllable
    private let homeBuilder: HomeBuildable
    private let randomColorBuilder: RandomBuildable
    
    private var homeRouting: HomeRouting?
    private var randomColorRouting: RandomRouting?
    
    init(interactor: HomeFlowInteractable, rootVc: RootViewControllable, homeBuilder: HomeBuildable, randomColorBuilder: RandomBuildable, homeRouting: HomeRouting? = nil, randomColorRouting: RandomRouting? = nil) {
        self.rootVc = rootVc
        self.homeBuilder = homeBuilder
        self.randomColorBuilder = randomColorBuilder
        self.homeRouting = homeRouting
        self.randomColorRouting = randomColorRouting
        super.init(interactor: interactor)
        interactor.router = self
    }
    
    func start(name: String) {
        let home = homeBuilder.build(withListener: interactor, name: name)
        attachChild(home)
        
        homeRouting = home
        rootVc.setRoot(home.viewControllable, animated: false)
    }
    
    func routeToRandomColor() {
        guard homeRouting != nil else { return }
        let random = randomColorBuilder.build(withListener: interactor)
        attachChild(random)
        randomColorRouting = random
        rootVc.push(random.viewControllable, animated: true)
    }
    
    func routeBackToHome() {
        guard let random = self.randomColorRouting else { return }
        rootVc.pop(animated: true)
        detachChild(random)
        randomColorRouting = nil
    }
    
}

