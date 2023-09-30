import Foundation
import simd
import Metal


public protocol GameNode: AnyObject, Transformable, Identifiable, Nameable {
    var name: String { get }
    var parent: (any GameNode)? { get set }
    var children: [any GameNode] { get set }
}
extension GameNode{
    public func addChild(_ child: any GameNode){
        children.append(child)
        child.parent = self
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
	public func assignModelMatrix(to encoder: MTLRenderCommandEncoder){
		encoder.setVertexBytes(&modelMatrix, length: simd_float4x4.stride(), index: 1)
	}
}
//public class GameNode: Identifiable{
//    
//    public var id: Int = Int.NextID()
//    public var name: String = ""
//    public var parent: GameNode?
//    public var children: [GameNode] = []
//    
//    public init(name: String, parent: GameNode? = nil){
//        self.name = name
//        self.parent = parent
//    }
//    
//    public func addChild(_ child: GameNode){
//        children.append(child)
//        child.parent = self
//    }
//    open func doUpdate(deltaTime: Float) {    }
//}
