public protocol Actionable: AnyObject{
	var actions: [any Action] { get set }
}

extension Actionable{
	public func collectGarbage(counter: TickCounter{
		
		actions.removeAll(where: {
			$0.status == .idle && counter - $0.lastCounter > 60})
	}
	public func runActions(counter: TickCounter){
		for i in 0..<actions.count{
			actions[i].step(counter: ticks)
		}
	}
}