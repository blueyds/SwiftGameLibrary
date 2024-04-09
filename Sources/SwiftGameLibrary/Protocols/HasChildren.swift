import Metal

public protocol HasChildren: AnyObject, Transformable{
	var children: [GameNode] { get set }
}

extension HasChildren{
	
	public func updateChildren(counter ticks: TickCounter){
		children.forEach(){
            $0.updateAll(counter: ticks)
        }
	}
	
	public func updateChildMatrices(){
		children.forEach(){
			$0.updateMatrices(parentMatrix: modelMatrix)
		}
	}
	
	public func add(child: GameNode){
        children.append(child)
    }
	
	public func renderChildren(with encoder: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState){
		children.forEach() { 
			$0.renderAll(with: encoder, currentState)
		}
	}
}