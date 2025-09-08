//
//  RandomView.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 9/8/25.
//

import UIKit
import RxSwift
import RxCocoa

final class RandomView: UIView {
    
    private let colorChangeButton = UIButton().after { b in
        b.setTitle("색상 바꾸기", for: .normal)
        b.setTitleColor(.cyan, for: .normal)
        b.backgroundColor = .lightGray
        b.titleLabel?.font = .boldSystemFont(ofSize: 24)
        b.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let backButton = UIButton().after {
        $0.setTitle("BACK", for: .normal)
        $0.backgroundColor = .lightGray
        $0.setTitleColor(.red, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Internal
    enum RandomViewEvent {
        case colorChange
        case backButtonTapped
    }
    
    let viewEventStream = PublishRelay<RandomViewEvent> ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        subscribeUIEvent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UI
extension RandomView {
    private func setUI() {
        self.backgroundColor = .random
        self.addSubview(backButton)
        self.addSubview(colorChangeButton)
        
        NSLayoutConstraint.activate([
            colorChangeButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40),
            colorChangeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorChangeButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
            
            backButton.topAnchor.constraint(equalTo: colorChangeButton.bottomAnchor, constant: 20),
            backButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}

// MARK: UI Event
extension RandomView {
    private func subscribeUIEvent() {
        colorChangeButton.addAction(UIAction(handler: { [weak self] _ in
            guard let owner = self else { return }
            owner.viewEventStream.accept(.colorChange)
        }), for: .touchDown)
        
        backButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.viewEventStream.accept(.backButtonTapped)
            }
            .disposed(by: rx.disposeBag)
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    RandomViewController()
}
#endif
