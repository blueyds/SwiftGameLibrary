import Metal

public protocol HasChildren: AnyObject{
	var children: [String: GameNode] { get set }
}

extension HasChildren{
	
	internal func updateChildren(counter ticks: TickCounter){
		for child in children.values{
			child.updateAll(counter: ticks)
		}
	}
	
	internal func updateChildMatrices(parentMatrix modelMatrix: Matrix, viewMatrix: Matrix){
		for child in children.values{
			child.updateMatrices(parentMatrix: modelMatrix, viewMatrix: viewMatrix)
		}
	}

	
	
	internal func renderChildren(with encoder: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState){
		for child in children.values {
			child.renderAll(with: encoder, currentState)
		}
	}
	
	func getAllChildren()->[GameNode]{
		var result: [GameNode] = []
		for child in children.values{
			result.append(child)
			result.append(contentsOf: child.getAllChildren())
		}
		return result
 	}
	
	func filterChilden(where filterFn: ((GameNode)->Bool))->[GameNode]{
		return getAllChildren().filter(filterFn)
	}
	
	public func getSubLevel(_ levels: String...)->GameNode?{
		var nodeIndices = levels
		var result: GameNode? = children[nodeIndices.removeFirst()]
		nodeIndices.forEach(){
			result = result?.children[$0]
		}
		return result
	}
}