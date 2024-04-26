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
	
	internal func updateChildMatrices(parentMatrix modelMatrix: Matrix){
		children.forEach(){
			$0.updateMatrices(parentMatrix: modelMatrix)
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
}