
public protocol Action {
	var frequency: CounterInterval { get set }
	func doStep()
}
extension Action{
	public mutating func step(counter ticks: TickCounter){
		if frequency.isLapsed(current: ticks){
			doStep()
			frequency.reset(counter: ticks)
		}
	}
}
