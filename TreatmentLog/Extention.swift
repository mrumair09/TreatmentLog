//
//  Extention.swift
//  TreatmentLog
//
//  Created by Umair Yousaf on 10/12/2022.
//

import Foundation
import UIKit

extension UIApplication {
    
    class func getTopViewController(base: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
    class func topNavigation(_ viewController: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UINavigationController? {
        
        if let nav = viewController as? UINavigationController {
            return nav
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return selected.navigationController
            }
        }
        if let presented = viewController?.presentedViewController {
            return topNavigation(presented)
        }
    
        return viewController?.navigationController as? UINavigationController
    }
}
