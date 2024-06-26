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
	
	//public func hitTest() { }
	public func isHitTested(ray: Ray, parentScale: SIMD3<Float> = .one)-> HitResult?{
		hitTestAllChildren(ray: ray, parentScale: scale)
	}

	public func hitTestAllChildren(ray: Ray, parentScale: SIMD3<Float> = .one)->HitResult?{
		for key in children.keys{
			if let hit = children[key]!.isHitTested(ray: ray, parentScale: parentScale * scale){
					var result = hit
					result.changeTopLevel(to: self)
					return result
			}
		}
		return nil
	}
}