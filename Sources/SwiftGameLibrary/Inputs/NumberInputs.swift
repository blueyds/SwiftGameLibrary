public class NumberInputs{
	public static var shared: NumberInputs = NumberInputs()
	
	private var numbers: [Float] = []
	
	private init(){
		initalizeNumbers(size: 8)
	}
	public func initializeNumbers(size: Int){
		numbers = []
		numbers.append(0, count: size)
	}
}

extension NumberInputs{
	private func isValid(_ index: Int)-> Bool{
		if numbers[index] != nil { return true}
		fatalError("index \(index) invalid in call to NumberInputs")
	}
	
	public func set(_ value: Float, at index: Int){
		if isValid(index){}
		numbers[index] = value
	}
	public func get(from index: Int) -> Float {
		if isValid(index){}
		return numbers[index]
	}
}