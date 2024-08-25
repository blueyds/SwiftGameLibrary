import Foundation

public protocol InputStringsEnum:CaseIterable, RawRepresentable where RawValue == Int{
	var value: String { get }
	func set(to: String)
}
extension InputStringsEnum{
	public var value: String{
		InputManager.shared.get(stringID: self.rawValue)!
	}
	public func set(to value: String){
		InputManager.shared.set(stringID: self.rawValue, to: value)
	}
}
