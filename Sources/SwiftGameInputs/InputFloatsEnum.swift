import Foundation

public protocol InputFloatsEnum:CaseIterable, RawRepresentable where RawValue == Int{
	var value: Float { get }
	func set(to: Float)
}
extension InputFloatsEnum{
	public var value: Float{
		InputManager.shared.get(floatID: self.rawValue)!
	}
	public func set(to value: Float){
		InputManager.shared.set(floatID: self.rawValue, to: value)
	}
}
