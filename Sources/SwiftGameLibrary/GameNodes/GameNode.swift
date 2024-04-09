import Foundation
import Metal


open class GameNode: Transformable, Identifiable, Nameable, Actionable, HasChildren {
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
    
    final public func updateMatrices(_ parent: Matrix){
        calculateModelMatrix(parent: parent)
        updateChildMatrices(parent.modelMatrix)
    }
    
    final public func renderAll(with encoder: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState){
		encoder.pushDebugGroup("NODE \(name)")
        tryToRenderMe(with: encoder, currentState: currentState)
        renderChildren(with: encoder: currentState: currentState)
		encoder.popDebugGroup()
    }
     private func tryToRenderMe(with encoder: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState){
        if let renderedMesh = mesh {
			renderedMesh.render(using: encoder, currentState: currentState, at: self)
			
            }
    }
} 