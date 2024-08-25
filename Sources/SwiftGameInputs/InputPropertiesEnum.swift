//
//  File.swift
//  
//
//  Created by Craig Nunemaker on 6/25/24.
//

import Foundation

/// Allows you to easily wrap a simple enum into a protocol that allows you to use the enum
/// to set and get InputManager property values by calling one of the already defined
/// protocol methods
public protocol InputPropertiesEnum: CaseIterable, RawRepresentable where RawValue == String{
	var value: String { get }
	func set(to: String)
}

extension InputPropertiesEnum{
	public var value: String{
		InputManager.shared.get(property: self.rawValue)!
	}
	public func set(to value: String){
		InputManager.shared.set(property: self.rawValue, to: value)
	}
}
