//
//  StatusBarStyle.swift
//  SlideMenu2
//
//  Created by Mher Melkonyan on 10/26/21.
//

import SwiftUI
import UIKit

class LocalStatusBarStyle {
    fileprivate var getter: () -> UIStatusBarStyle = { .default }
    fileprivate var setter: (UIStatusBarStyle) -> Void = { _ in }
    
    var currentStyle: UIStatusBarStyle {
        get { self.getter() }
        set { self.setter(newValue) }
    }
}

struct LocalStatusBarStyleKey: EnvironmentKey {
    static let defaultValue: LocalStatusBarStyle = LocalStatusBarStyle()
}

extension EnvironmentValues {
    var localStatusBarStyle: LocalStatusBarStyle {
        get {
            return self[LocalStatusBarStyleKey.self]
        }
    }
}

// See SceneDelegate.swift (func scene)
class MyHostingController<Content>: UIHostingController<Content> where Content: View {
    private var internalStyle = UIStatusBarStyle.default
    
    @objc override dynamic open var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            internalStyle
        }
        set {
            internalStyle = newValue
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override init(rootView: Content) {
        super.init(rootView: rootView)
        
        LocalStatusBarStyleKey.defaultValue.getter = { self.preferredStatusBarStyle }
        LocalStatusBarStyleKey.defaultValue.setter = { self.preferredStatusBarStyle = $0 }
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

