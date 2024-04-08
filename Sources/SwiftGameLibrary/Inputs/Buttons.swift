public class Buttons {
	public static var shared: Buttons = Buttons()
	private init(){
		initializeButtons(size: 10)
	}
	
	private var buttons: [Bool] = []
	public func clearButtons(){
		for i in 0..<buttons.count {
			if buttons[i] == true { 
				buttons[i] = false
			}
		}
	}
	public func initializeButtons(size: Int){
		buttons = []
		buttons.append(false, count: size)
	}
	public func isPressed(button: Int) -> Bool{
		if isValid(index: button) {}
		return buttons[button]
	}
	private func isValid(index: Int)-> Bool{
		if index < buttons.count { return true}
		fatalError("index \(index) invalid in call to class Buttons")
	}
	public func press(button: Int){
		if isValid(index: button) {}
		buttons[button] = true
	}
	public func depress(button: Int){
		if isValid(index: button){}
		buttons[button] = false
	}
	public func toggle(button: Int){
		if isValid(index: button){ }
		buttons[button].toggle()
	}
}