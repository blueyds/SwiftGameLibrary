
public protocol Action {
	var frequency: CounterInterval { get set }
	func doStep()
}
extension Action{
	public func step(counter ticks: TickCounter){
		if frequency.isLapsed(current: ticks){
			doStep()
			frequency.reset(counter: ticks)
		}
	}
}
