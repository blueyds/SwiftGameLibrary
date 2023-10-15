import Foundation
import simd
import Metal


public protocol GameNode: AnyObject, Transformable, Identifiable, Nameable {
    var children: [any GameNode] { get set }
    func updateMatrices(parent: Matrix)
}
extension GameNode{
    public func add(child: any GameNode){
        children.append(child)
      //  child.parent = self
    }
    public func updateMeAndChildren() {
        if let updateMe = self as? Updateable {
            updateMe.doUpdate()
        }
        children.forEach(){
            $0.updateMeAndChildren()
        }
    }
    
    public func updateMatrices(parent: Matrix){
        calculateModelMatrix(parent: parent)
        children.forEach(){
            $0.updateMatrices(parent: matrices[0])
        }
    }
    
    public func renderAll(with encoder: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState){
        tryToRenderMe(with: encoder, currentState: currentState)
        children.forEach(){ $0.renderAll( with: encoder, currentState: currentState) }
    }
     func tryToRenderMe(with encoder: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState){
        if let renderedObject = self as? Renderable {
				renderedObject.render(using: encoder, currentState: currentState)
            }
    }
} 