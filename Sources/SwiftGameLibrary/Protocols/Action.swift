
public protocol Action {
	var frequency: CounterInterval { get set }
	func doStep()
}
extension Action{
	public func step(counter: TickCounter){
		if frequency.isLapsed(counter){
			doStep()
			frequency.reset(counter: counter)
		}
	}
}
