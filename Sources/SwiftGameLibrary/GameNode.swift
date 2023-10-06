import Foundation
import simd
import Metal


public protocol GameNode: AnyObject, Transformable, Identifiable, Nameable {
    var children: [any GameNode] { get set }
}
extension GameNode{
    public func addChild(_ child: any GameNode){
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
            $0.updateMatrices(parent: transforms.matrix)
        }
    }
    
    public func renderAll(with encoder: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState){
        tryToRenderMe(with: encoder, currentState: currentState)
        children.forEach(){ $0.renderAll( with: encoder, currentState: currentState) }
    }
     func tryToRenderMe(with encoder: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState){
        if let renderedObject = self as? Renderable {
				encoder.pushDebugGroup($0.name)
				renderedObject.render(using: encoder, currentState: currentState)
				encoder.popDebugGroup()
            }
    }
} 