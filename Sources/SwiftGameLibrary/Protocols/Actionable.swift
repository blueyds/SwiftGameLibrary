public protocol Actionable: AnyObject{
	var actions: [any Action] { get set }
}

extension Actionable{
	public func collectGarbage(counter ticks: TickCounter){
		
		actions.removeAll(where: {
			$0.status == .idle && ticks - $0.lastCounter > 60})
	}
	public func runActions(counter ticks: TickCounter){
		for i in 0..<actions.count{
			actions[i].step(counter: ticks)
		}
	}
}