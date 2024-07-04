import Metal

public protocol HasChildren: AnyObject{
	var children: [any GameNode] { get set }
}

extension HasChildren{
	public func add(child: any GameNode){
		children.append(child)
	}
	
	internal func updateChildren(counter ticks: TickCounter){
		for child in children{
			child.updateAll(counter: ticks)
		}
	}
	
	internal func updateChildMatrices(parentMatrix modelMatrix: Matrix, viewMatrix: Matrix){
		for child in children{
			child.updateMatrices(parentMatrix: modelMatrix, viewMatrix: viewMatrix)
		}
	}

	
	
	internal func renderChildren(with encoder: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState){
		for child in children {
			child.renderAll(with: encoder, currentState)
		}
	}
	
	func getAllChildren()->[any GameNode]{
		var result: [any GameNode] = []
		for child in children{
			result.append(child)
			result.append(contentsOf: child.getAllChildren())
		}
		return result
 	}
	
	func filterChilden(where filterFn: ((any GameNode)->Bool))->[any GameNode]{
		return getAllChildren().filter(filterFn)
	}
//	TODO: Rework with simple array
//	public func getSubLevel(_ levels: String...)->(any GameNode)?{
//		var nodeIndices = levels
//		var result: GameNode? = children[nodeIndices.removeFirst()]
//		nodeIndices.forEach(){
//			result = result?.children[$0]
//		}
//		return result
//	}
}
