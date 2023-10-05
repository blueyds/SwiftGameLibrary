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
        self.modelMatrix = calculateModelMatrix(parent: modelMatrix)
        children.forEach(){
            $0.updateMatrices(parent: modelMatrix)
        }
    }
}