//
//  PrivacyPolicyViewController.swift
//  TestOnseo
//
//  Created by Oleg Pogosian on 04.07.2020.
//  Copyright © 2020 Oleg Pogosian All rights reserved.
//

import UIKit

protocol BaseViewControllerProtocol: class {
    func showMessageAlert(_ message: String)
    func showErrorAlert(message: String)
    func showChoiceAlert(title: String? , message: String?, customActions: [UIAlertAction])
}

protocol PrivacyPolicyViewControllerProtocol: BaseViewControllerProtocol {
    func showHome()
}

class PrivacyPolicyViewController: UIViewController {
        
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var placeholderButtonLabel: UILabel!
    @IBOutlet weak var agreeButton: UIButton!
    
    // MARK: - Properties
    var presenter: PrivacyPolicyPresenterProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = PrivacyPolicyPresenter(view: self)
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()

      textView.contentOffset = .zero
    }
    
    // MARK: - UI
    private func setupViews() {
        agreeButton.viewCorner(8)
        textView.text = "\tLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.\n\tLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.\n\tLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.\n\tLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.\n\tLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    }
    
    // MARK: - IBActions
    @IBAction func pressCancelButton(_ sender: UIButton) {
        presenter.pressCancel()
    }
    
    @IBAction func pressAgreeButton(_ sender: UIButton) {
        presenter.pressAgree()
    }
    
}

extension PrivacyPolicyViewController: PrivacyPolicyViewControllerProtocol {
    
    func showHome() {
        let nv = UINavigationController(rootViewController: MoviesViewController.instance(.home))
        UIApplication.shared.keyWindow?.rootViewController = nv
    }
}
