import Metal

public protocol HasChildren: AnyObject{
	var children: [GameNode] { get set }
}

extension HasChildren{
	
	internal func updateChildren(counter ticks: TickCounter){
		children.forEach(){
            $0.updateAll(counter: ticks)
        }
	}
	
	internal func updateChildMatrices(parentMatrix modelMatrix: Matrix, viewMatrix: Matrix){
		children.forEach(){
			$0.updateMatrices(parentMatrix: modelMatrix, viewMatrix: viewMatrix)
		}
	}
	public func add(child: GameNode){
		children.append(child)
	}
	
	
	internal func renderChildren(with encoder: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState){
		children.forEach() {
			$0.renderAll(with: encoder, currentState)
		}
	}
	
	func getAllChildren()->[GameNode]{
        var result: [GameNode] = []
        children.forEach(){
            result.append($0)
            result.append(contentsOf: $0.getAllChildren())
        }
        return result
 	}
	
	func filterChilden(where filterFn: ((GameNode)->Bool))->[GameNode]{
        return getAllChildren().filter(filterFn)
    }
}