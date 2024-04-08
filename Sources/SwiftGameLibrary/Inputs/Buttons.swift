public class Buttons {
	public static shared: Buttons = Buttons()
	private init(){
		initalizeButtons(size: 10)
	}
	
	private buttons: [Bool] = []
	public func clearButtons(){
		for i in buttons.index {
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
		if button[index] != nil { return true}
		fatalError("index \(index) invalid in call to class Buttons")
	}
	public func press(button i: Int){
		if isValid(i) {}
		button[i] = true
	}
	public func depress(button i: Int){
		if isValid(i){}
		button[i] = false
	}
	public func toggle(button i: Int){
		if isValid(i){ }
		button[i].toggle()
	}
}