import Foundation
import Metal


open class GameNode: Transformable, Identifiable, Nameable {
	public let id: Int
	public let name: String
	public var position: float3 = float3.Zero
	public var rotation: float3 = float3.Zero
	public var scale: float3 = float3.One
	public var parent: GameNode? = nil
	public var modelMatrix: Matrix = Matrix.identity
	public var mesh: Mesh? = nil

	var children: [GameNode] = []
	var actions: [any Action] = []
	
	public init(){
		self.id = Int.NextID()
		self.name = "NONAME id\(self.id)"
	}
	
	public init(named: String, mesh: Mesh){
		self.id = Int.NextID()
		self.mesh = mesh
	}
	
    final public func add(child: GameNode){
        children.append(child)
        child.parent = self
    }
	
	public func attach(action: any Action ){
		actions.append(action)
	}
    
	final public func updateAll(counter ticks: TickCounter) {
        updateMe(counter: ticks)
        children.forEach(){
            $0.updateAll(counter: ticks)
        }
    }
    
	private func updateMe(counter ticks: TickCounter){
		for i in 0..<actions.count{
			actions[i].step(counter: ticks)
		}
    }
    final public func updateMatrices(parent: Matrix){
        calculateModelMatrix(parent: parent)
        children.forEach(){
            $0.updateMatrices(parent: modelMatrix)
        }
    }
    
    final public func renderAll(with encoder: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState){
		encoder.pushDebugGroup("NODE \(name)")
        tryToRenderMe(with: encoder, currentState: currentState)
        children.forEach(){ 
			$0.renderAll( with: encoder, currentState: currentState) 
		}
		encoder.popDebugGroup()
    }
     private func tryToRenderMe(with encoder: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState){
        if let renderedMesh = mesh {
			renderedMesh.render(using: encoder, currentState: currentState, at: self)
			
            }
    }
} 