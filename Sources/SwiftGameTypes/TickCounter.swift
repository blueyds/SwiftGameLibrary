public struct TickCounter{
	public typealias T = Int
	private var value: T = 0
	public var ticks: T { value }
	
	public init(){ 	}
	
	public init(tickCounter: TickCounter){
		value = tickCounter.ticks
	}
	public init(ticks: T){
		value = ticks
	}
	// normal return true
	// return false if the Tickcounter will overflow. In this case the tickcounter 
	// will reset to zero and return false so the call function
	// can do stuff also
	public mutating func increment(){
		value += 1
	}
}

extension TickCounter{
	static public func +(left: TickCounter, right: T) -> TickCounter{
		return TickCounter(ticks: left.ticks + right)
	}
	static public func -(left: TickCounter, right: T) -> TickCounter{
		return TickCounter(ticks: left.ticks - right)
	}
}

extension TickCounter: Equatable{
	static public func ==(lhs: TickCounter, rhs: TickCounter) -> Bool{
		return (lhs.ticks == rhs.ticks)
	}
}
extension TickCounter: Comparable{
	static public func <(lhs: TickCounter, rhs: TickCounter) -> Bool{
		return (lhs.ticks < rhs.ticks)
	}
}

extension Int{
	public init(_ counter: TickCounter){
		self = counter.ticks
	}
}