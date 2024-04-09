import Foundation
import Metal


open class GameNode: Transformable, Identifiable, Nameable, Actionable, HasChildren {
	public let id: Int
	public let name: String
	public var position: float3 = float3.Zero
	public var rotation: float3 = float3.Zero
	public var scale: float3 = float3.One
	//public var parent: GameNode? = nil
	public var modelMatrix: Matrix = Matrix.identity
	public var mesh: Mesh? = nil

	public var children: [GameNode] = []
	public var actions: [any Action] = []
	
	public init(){
		self.id = Int.NextID()
		self.name = "NONAME id\(self.id)"
	}
	
	public init(named: String, mesh: Mesh){
		self.id = Int.NextID()
		self.name = named
		self.mesh = mesh
	}
	
	
	public func attach(action: any Action ){
		actions.append(action)
	}
    
	open func doUpdate(counter ticks: TickCounter) { }
	
	final public func updateAll(counter ticks: TickCounter) {
        doUpdate(counter: ticks)
		runActions(counter: ticks)
        updateChildren(counter: ticks)
    }
    
    final public func updateMatrices(parentMatrix matrix: Matrix){
        calculateModelMatrix(parentMatrix: matrix)
        updateChildMatrices()
    }
    
    final public func renderAll(with encoder: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState){
		encoder.pushDebugGroup("NODE \(name)")
        tryToRenderMe(with: encoder, currentState)
        renderChildren(with: encoder, currentState)
		encoder.popDebugGroup()
    }
     private func tryToRenderMe(with encoder: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState){
        if let renderedMesh = mesh {
			renderedMesh.render(using: encoder, currentState, at: self)
			
            }
    }
} 