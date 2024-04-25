public protocol Actionable: AnyObject{
	var actions: [any Action] { get set }
}

extension Actionable{
	public func collectGarbage(counter ticks: TickCounter){
		
		actions.removeAll(where: {$0.isDead(counter: ticks)})
	}
	public func runActions(counter ticks: TickCounter){
		for i in 0..<actions.count{
			actions[i].step(counter: ticks)
		}
	}
	
}