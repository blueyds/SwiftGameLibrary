
public protocol Action {
	var frequency: CounterInterval { get set }
	var status: ActionStatus { get }
	func doStep()
}
extension Action{
	public mutating func step(counter ticks: TickCounter){
		if frequency.isLapsed(current: ticks) && status != .idle {
			doStep()
			frequency.reset(counter: ticks)
		}
	}
	public func isDead(counter: TickCounter)->Bool{
		(status == .idle) && (Int(counter) - Int(frequency.lastCounter) > 60)
	}
}

public enum ActionStatus{
	case running
	case highPriority
	case idle
}