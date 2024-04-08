public struct CounterInterval{
	
	public typealias T = Int
	public var lastCounter: TickCounter = TickCounter()
	public var frequency: T
	
	public func isLapsed(current: TickCounter)->Bool{
		if current - frequency ≥ lastCounter{ return true }
		return false
	}
	public func reset(counter: TickCounter){
		lastCounter = counter
	}
	
}