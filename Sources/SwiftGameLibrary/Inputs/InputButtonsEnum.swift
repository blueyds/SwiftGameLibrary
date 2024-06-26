import Foundation

public protocol InputButtonsEnum:CaseIterable, RawRepresentable where RawValue == Int{
	var isPressed: Bool { get }
	func press()
	func depress()
	static func clearAll()
}
extension InputButtonsEnum{
	public var isPressed: Bool{
		InputManager.shared.get(button: self.rawValue)
	}
	public func press(){
		InputManager.shared.set(button: self.rawValue, to: true)
	}
	public func depress(){
		InputManager.shared.set(button: self.rawValue, to: false)
	}
	static public func clearAll(){
		InputManager.shared.initialzeButtons(size: self.allCases.count)
	}
}
