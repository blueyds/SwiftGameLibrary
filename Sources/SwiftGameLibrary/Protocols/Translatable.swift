import simd

public protocol Translatable: AnyObject{
    var position: float3 { get set }
    
}

extension Translatable{
    
    
    public func moveX(by delta: Float){
        position.x += delta
    }
    public func moveY(by delta: Float){
        position.y += delta
    }
    public func moveZ(by delta: Float){
        position.z += delta
    }
}
