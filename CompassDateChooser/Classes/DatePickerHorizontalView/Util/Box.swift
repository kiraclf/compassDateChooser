//
//  Box.swift
//  CompassDateChooser_Example
//
//  Created by compass on 2020/7/9.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

/// Box type was used by viewModle to bind with view.
public final class Box<T> {
  //1
  public typealias Listener = (T) -> Void
  public  var listener: Listener?
  //2
  public var value: T {
    didSet {
      listener?(value)
    }
  }
  //3
  public init(_ value: T) {
    self.value = value
  }
  //4
  public func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
