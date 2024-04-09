import Metal

public protocol HasChildren: AnyObject{
	var children: [GameNode] { get set }
}

extension HasChildren{
	
	public func updateChildren(counter ticks: TickCounter){
		children.forEach(){
            $0.updateAll(counter: ticks)
        }
	}
	
	public func updateChildMatrices(_ parent: Matrix){
		children.forEach(){
			$0.updateMatrices(parent)
		}
	}
	
	public func add(child: GameNode){
        children.append(child)
    }
	
	public func add(child: GameNode, parent: GameNode){
        children.append(child)
        child.parent = parent
    }
	public func renderChildren(with encoder: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState){
		children.forEach() { 
			$0.renderAll(with: encoder, currentState: currentState)
		}
	}
}