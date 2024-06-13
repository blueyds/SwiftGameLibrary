import Foundation
import simd
import Metal
import RegexBuilder


open class GameNode: Transformable, Identifiable, Nameable, Actionable, HasChildren {
	public let id: Int
	public var name: String
	public var position: SIMD3<Float> = .zero
	public var rotation: SIMD3<Float> = .zero
	public var scale: SIMD3<Float> = .one
	//public var parent: GameNode? = nil
	public var modelMatrix: Matrix = Matrix.identity
	public var normalMatrix: simd_float3x3 = .identity
	public var children: [String: GameNode] = [:]
	public var actions: [any Action] = []
	
	public init(){
		self.id = Int.NextID()
		self.name = "GAMENODE_\(self.id)"
	}
	
	public init(named: String){
		self.id = Int.NextID()
		self.name = named
	}
	init(prepend: String){
		self.id = Int.NextID()
		self.name = "\(prepend)_\(self.id)"
	}
	
	public func add(child: GameNode){
		let search = Regex{
			OneOrMore(.word)
			One("/")
		}
		let post = child.name.trimmingPrefix(search)
		let newName = name + "/" + post
		child.name = newName
		children.updateValue(child, forKey: child.name)
	}
	open func doUpdate(counter: TickCounter) { }
	
	final public func updateAll(counter ticks: TickCounter) {
        doUpdate(counter: ticks)
		runActions(counter: ticks)
        updateChildren(counter: ticks)
    }
    
    final public func updateMatrices(parentMatrix: Matrix, viewMatrix: Matrix){
        self.modelMatrix = calculateModelMatrix(parentMatrix)
		let modelViewMatrix = viewMatrix * modelMatrix
		let mVM = simd_float3x3(modelViewMatrix[0].xyz,
								modelViewMatrix[1].xyz,
								modelViewMatrix[2].xyz)
		normalMatrix = mVM.inverse.transpose
        updateChildMatrices(parentMatrix: modelMatrix, viewMatrix: viewMatrix)
    }
    
    final public func renderAll(with encoder: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState){
		encoder.pushDebugGroup("NODE \(name)")
        doRender(with: encoder, currentState)
        renderChildren(with: encoder, currentState)
		encoder.popDebugGroup()
    }
	
	// TODO: This is hidden and fixed. it would be hard to modify to render
	// with different modelmatrix ie for animation
	
     func doRender(with: MTLRenderCommandEncoder, _ : MTLRenderPipelineState){ }
	
}

// builder extensions
extension GameNode{
	public func Position(x: Float = 0, y: Float = 0, z: Float = 0)->GameNode{
		position.x = x
		position.y = y
		position.z = z
		return self
	}
	
	public func Scale(x: Float = 1, y: Float = 1, z: Float = 1)->GameNode{
		scale.x = x
		scale.y = y
		scale.z = z
		return self
	}
	
	public func Rotation(x: Float = 0, y: Float = 0, z: Float = 0)->GameNode{
		rotation.x = x
		rotation.y = y
		rotation.z = z
		return self
	}
}