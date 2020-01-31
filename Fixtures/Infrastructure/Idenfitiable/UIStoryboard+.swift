//
//  UIStoryboard+.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

 import Foundation

#if os(iOS)
  import UIKit

  extension UIStoryboard {
    func instantiateViewController<T>(ofType type: T.Type) -> T {
      return instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
  }
#elseif os(OSX)
  import Cocoa

  extension NSStoryboard.Name: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
      self.init(value)
    }
  }

  extension NSStoryboard {
    func instantiateViewController<T>(ofType type: T.Type) -> T {
      let scene = SceneIdentifier(String(describing: type))
      return instantiateController(withIdentifier: scene) as! T
    }
  }
#endif
