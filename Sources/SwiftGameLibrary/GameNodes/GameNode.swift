import Foundation
import Metal


open public class GameNode: Transformable, Identifiable, Nameable {
	public let id = Int.NextID()
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
		self.name = ""
	}
	
	public init(named: String, mesh: Mesh){ }
	
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
		actions.forEach(){
			$0.step(counter: ticks)
		}
    }
    final public func updateMatrices(parent: Matrix){
        calculateModelMatrix(parent: parent)
        children.forEach(){
            $0.updateMatrices(parent: modelMatrix)
        }
    }
    
    final public func renderAll(with encoder: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState){
        tryToRenderMe(with: encoder, currentState: currentState)
        children.forEach(){ $0.renderAll( with: encoder, currentState: currentState) }
    }
     private func tryToRenderMe(with encoder: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState){
        if let renderedMesh = mesh {
			encoder.pushDebugGroup("NODE \(name)")
			renderedMesh.render(using: encoder, currentState: currentState, at: self)
			encoder.popDebugGroup()
            }
    }
} 