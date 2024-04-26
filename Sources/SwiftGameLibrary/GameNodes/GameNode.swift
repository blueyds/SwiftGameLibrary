import Foundation
import simd
import Metal


open class GameNode: Transformable, Identifiable, Nameable, Actionable, HasChildren {
	public let id: Int
	public let name: String
	public var position: SIMD3<Float> = .zero
	public var rotation: SIMD3<Float> = .zero
	public var scale: SIMD3<Float> = .one
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
	
	
	
	open func doUpdate(counter ticks: TickCounter) { }
	
	final public func updateAll(counter ticks: TickCounter) {
        doUpdate(counter: ticks)
		runActions(counter: ticks)
        updateChildren(counter: ticks)
    }
    
    final public func updateMatrices(parentMatrix: Matrix){
        self.modelMatrix = calculateModelMatrix(parentMatrix)
        updateChildMatrices()
    }
    
    final public func renderAll(with encoder: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState){
		encoder.pushDebugGroup("NODE \(name)")
        tryToRenderMe(with: encoder, currentState)
        renderChildren(with: encoder, currentState)
		encoder.popDebugGroup()
    }
	
	// TODO: This is hidden and fixed. it would be hard to modify to render
	// with different modelmatrix ie for animation
     private func tryToRenderMe(with encoder: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState){
        if let renderedMesh = mesh {
			renderedMesh.render(with: encoder, currentState, modelMatrix: modelMatrix)
			
            }
    }
} 