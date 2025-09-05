//
//  LoginView.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 9/5/25.
//

import UIKit

final class LoginView: UIView {
    // 시작 버튼
    let button = UIButton().after {
        var config = UIButton.Configuration.filled()
        config.title = "로그인"
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)
        $0.configuration = config
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UI Layer
extension LoginView {
    
    private func setUI() {
        self.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
