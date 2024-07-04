import Foundation
import simd
import Metal
import RegexBuilder


public protocol GameNode: AnyObject, Identifiable, HasChildren  {
	var transforms: [Transformable] { get set }
	//public var parent: GameNode? = nil
	var actions: [any Action] { get set }

	func doUpdate(counter: TickCounter)
	func doRender(with: MTLRenderCommandEncoder, _ : MTLRenderPipelineState)

}
extension GameNode{

	public func doUpdate(counter: TickCounter) { }
	public func doRender(with: MTLRenderCommandEncoder, _ : MTLRenderPipelineState) { }

	public func add(child: any GameNode){
		children.append(child)
	}

	internal func runActions(counter ticks: TickCounter){
		for  index in actions.indices {
			actions[index].step(counter: ticks)
		}
	}

	internal func updateAll(counter ticks: TickCounter) {
        doUpdate(counter: ticks)
		runActions(counter: ticks)
        updateChildren(counter: ticks)
    }
    
    internal func updateMatrices(parentMatrix: Matrix, viewMatrix: Matrix){
		for index in transforms.indices{
			transforms[index].calculateModelMatrix(parentMatrix)
		}
		updateChildMatrices(parentMatrix: transforms[0].modelMatrix, viewMatrix: viewMatrix)
	}
	
	internal func renderAll(with encoder: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState){
		encoder.pushDebugGroup("NODE \(id)")
		doRender(with: encoder, currentState)
		renderChildren(with: encoder, currentState)
		encoder.popDebugGroup()
	}
	
	// TODO: This is hidden and fixed. it would be hard to modify to render
	// with different modelmatrix ie for animation
	

	//public func hitTest() { }
	public func isHitTested(ray: Ray, parentScale: SIMD3<Float> = .one)-> HitResult?{
		hitTestAllChildren(ray: ray, parentScale: transforms[0].scale)
	}

	internal func hitTestAllChildren(ray: Ray, parentScale: SIMD3<Float> = .one)->HitResult?{
		for child in children{
			if let hit = child.isHitTested(ray: ray, parentScale: parentScale * transforms[0].scale){
					var result = hit
					result.changeTopLevel(to: self)
					return result
			}
		}
		return nil
	}
}
