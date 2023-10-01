import Foundation
import simd
import Metal


public protocol GameNode: AnyObject, Transformable, Identifiable, Nameable {
    var name: String { get }
    //var parent: (any GameNode)? { get set }
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
            if let child = $0 as? Updateable {
                child.doUpdate()
            }
        }
    }
    
    public func updateChildrenMatrices(){
        for i in children.indices{
            children[i].modelMatrix = children[i].calculateModelMatrix(parent: modelMatrix)
            children[i].updateChildrenMatrices()
        }
    }
}