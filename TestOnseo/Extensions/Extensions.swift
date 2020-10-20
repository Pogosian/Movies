//
//  Extensions.swift
//  TestOnseo
//
//  Created by Oleg Pogosian on 04.07.2020.
//  Copyright © 2020 Oleg Pogosian All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    enum Storyboard {
        case main
        case home
        
        var title: String {
            return String(describing: self).firstUppercased
        }
    }
    
    convenience init(storyboard: Storyboard) {
        self.init(name: storyboard.title, bundle: nil)
    }
    
    func instantiateViewController<T: UIViewController>(_ type: T.Type) -> T {
        let id = NSStringFromClass(T.self).components(separatedBy: ".").last!
        return self.instantiateViewController(withIdentifier: id) as! T
    }
}

extension UIViewController {
    
    class func instance(_ storyboard: UIStoryboard.Storyboard) -> Self {
        
        let storyboard = UIStoryboard(storyboard: storyboard)
        let viewController = storyboard.instantiateViewController(self)
        
        return viewController
    }
    
    func showMessageAlert(_ message: String) {
        self.showAlert(title: nil, message: message, completion: {})
    }
    
    func showErrorAlert(message: String) {
        self.showAlert(title: "Error", message: message, completion: {})
    }
    
    func showChoiceAlert(title: String? , message: String?, customActions: [UIAlertAction]) {
        self.showAlert(title: title, message: message, customActions: customActions, completion: {})
    }
    
    func showAlert(title: String?, message: String?, customActions: [UIAlertAction] = [], completion: @escaping () -> Void) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            if customActions.isEmpty {
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {action in completion()}))
            } else {
                for action in customActions {
                    alert.addAction(action)
                }
            }
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension UIView {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    func viewCorner(_ radius: CGFloat? = nil) {
        layer.cornerRadius = radius ?? self.frame.height / 2
        layer.masksToBounds = true
    }
}

extension UITableView {
    
    func create<T: UITableViewCell>(_ cell: T.Type, _ indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as! T
    }
    
    func register<T: UITableViewCell>(_ cell: T.Type) {
        self.register(UINib(nibName: T.identifier, bundle: nil), forCellReuseIdentifier: T.identifier)
    }
}

extension StringProtocol {
    
    var firstUppercased: String {
        return prefix(1).uppercased() + dropFirst()
    }
}
