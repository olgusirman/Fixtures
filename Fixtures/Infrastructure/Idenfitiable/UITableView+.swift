//
//  UITableView+.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import Foundation

#if os(iOS)
  import UIKit

  extension UITableView {
    func dequeueCell<T>(ofType type: T.Type) -> T {
      return dequeueReusableCell(withIdentifier: String(describing: T.self)) as! T
    }
  }

#elseif os(OSX)
  import Cocoa

  extension NSTableView {
    func dequeueCell<T>(ofType type: T.Type) -> T {
      let id = NSUserInterfaceItemIdentifier(String(describing: T.self))
      return makeView(withIdentifier: id, owner: self) as! T
    }
  }

#endif
