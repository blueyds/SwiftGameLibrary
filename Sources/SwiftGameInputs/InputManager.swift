public class InputManager{
	public static var shared: InputManager = InputManager()
	private init(){}
	
	private var iButtons: [Int: Bool] = [:]
	private var iStrings: [Int:String] = [:]
	private var iFloats: [Int: Float] = [:]
	private var sStrings: [String: String] = [:]
	
	private var isLocked: Bool = false 
	private func waitUnlocked(){
		while (isLocked) {}
	}
	private func lock(){ 
		waitUnlocked()
		isLocked = true
	}
	private func unlock() { isLocked = false}
}

// Buttons extensions
extension InputManager{
	public func set(button: Int, to value: Bool){
		lock()
		if iButtons.updateValue(value, forKey: button) == nil {
			print("InputManager.set(button: \(button), to: \(value)) set a key which was not already set")
		}
		unlock()
	}
	public func get(button: Int)->Bool{
		if let result = iButtons[button]{
			return result
		} else { return false}
	}
	public func initialzeButtons(size: Int){
		for i in 0..<size{
			set(button: i, to: false)
		}
	}
}

// Int Strings extensions
extension InputManager{
	public func set(stringID: Int, to value: String){
		lock()
		if iStrings.updateValue(value, forKey: stringID) == nil{
			print("InputManager.set(stringID: \(stringID), to: \(value)) set a key which was not already set")
		}
		unlock()
	}
	public func get(stringID: Int)->String?{
		iStrings[stringID]
	}
}

// String Strings extensions
extension InputManager{
	public func set(property: String, to value: String){
		lock()
		if sStrings.updateValue(value, forKey: property) == nil {
			print("InputManager.set(property: \(property), to: \(value)) set a key which was not already set")
		}
		unlock()
	}
	
	public func get(property: String)->String?{
		sStrings[property]
	}
}
// floats extensions
extension InputManager{
	public func set(floatID: Int, to value: Float){
		lock()
		if iFloats.updateValue(value, forKey: floatID) == nil{
			print("InputManager.set(floatId: \(floatID), to: \(value))  set a key that was not already set")
		}
		unlock()
	}
	
	public func get(floatID: Int)->Float?{
	    iFloats[floatID]
	}
}
