public class InputManager{
	public static var shared: InputManager = InputManager()
	private init(){}
	
	private var iButtons: [Int: Bool] = [:]
	private var iStrings: [Int:String?] = [:]
	private var iFloats: [Int: Float] = [:]
	private var sStrings: [String: String?] = [:]
	
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
			Log.info("InputManager.set(button:) tried to set a key which was not already set", button, value)
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
	public func set(stringID: Int, to value: String?){
		lock()
		if iStrings.updateValue(value, forKey: stringID) == nil{
			Log.info("InputManager.set(stringID: tried to set a key which was not already set", stringID, value)
		}
		unlock()
	}
	public func get(stringID: Int)->String?{
		if let result = iStrings[stringID]{
			return result
		} else { return nil }
	}
}

// String Strings extensions
extension InputManager{
	public func set(property: String, to value: String?){
		lock()
		if sStrings.updateValue(value, forKey: property) == nil {
			Log.info("InputManager.set tried to set a key which was not already set", property, value)
		}
		unlock()
	}
	
	public func get(property: String)->String?{
		if let result = sStrings[property]{
			return result
		} else { return nil }
	}
}
// floats extensions
extension InputManager{
	public func set(floatID: Int, to value: Float){
		lock()
		if iFloats.updateValue(value, forKey: floatID) == nil{
			Log.info("InputManager.set(floatId:) tried to set a key that was not already set", floatID, value)
		}
		unlock()
	}
	
	public func get(floatID: Int)->Float{
		if let result = iFloats[floatID]{
			return result
		}
		set(floatID: floatID, .zero)
		Log.info("tried to access prior key before it was set. created and set to zero", floatID, .zero)
		return .zero
	}
}
