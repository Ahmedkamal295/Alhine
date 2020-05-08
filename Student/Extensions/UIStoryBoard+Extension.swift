//
//  6.swift
//  TYOUT
//
//  Created by Ali Hamed on 9/25/18.
//  Copyright © 2018 Gra7. All rights reserved.
//

import Foundation
import UIKit

enum storyBoardName: String {
    case authentication = "Authentication"
    case landing = "Landing"
    case menu = "Menu"
}

enum storyBoardVCIDs: String {
    case AdsVC = "AdsVC"
    case IntroVC = "IntroVC"
    case signUp = "signUpVc"
    case home = "HomeVC"
    case login = "logInVc"
    case contactUsVc = "contactUsVc"
}




extension UIStoryboard {
    class func instantiateInitialViewController(_ board: storyBoardName) -> UIViewController {
        let story = UIStoryboard(name: board.rawValue, bundle: nil)
        return story.instantiateInitialViewController()!
    }
}
