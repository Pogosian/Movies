//
//  PrivacyPolicyPresenter.swift
//  TestOnseo
//
//  Created by Oleg Pogosian on 04.07.2020.
//  Copyright © 2020 Oleg Pogosian All rights reserved.
//

import UIKit

protocol PrivacyPolicyPresenterProtocol {
    init(view: PrivacyPolicyViewControllerProtocol)
    func pressCancel()
    func pressAgree()
}

class PrivacyPolicyPresenter: PrivacyPolicyPresenterProtocol {
    
    private unowned let view: PrivacyPolicyViewControllerProtocol

    required init(view: PrivacyPolicyViewControllerProtocol) {
        self.view = view
    }
    
    func pressCancel() {
        self.view.showChoiceAlert(title: "Are you sure?", message: nil, customActions: [
            UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                exit(0)
            }),
            UIAlertAction(title: "No", style: .cancel, handler: nil)])
    }
    
    func pressAgree() {
        self.view.showHome()
    }
    
}
