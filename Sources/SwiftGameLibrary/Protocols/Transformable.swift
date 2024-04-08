import simd

public protocol Transformable: AnyObject{
    var position: float3 { get set }
    var rotation: float3 { get set }
    var scale: float3 { get set}
    var modelMatrix: Matrix { get set}
}

extension Transformable{
    public func calculateModelMatrix(parent: Matrix = Matrix.identity){
        var result = Matrix.identity
        result.translateModel(position)
        result.rotate(rotation)
        result.scale(scale)
        modelMatrix = matrix_multiply(parent, result)
    }
}

extension Transformable{
    public func moveTo(x: Float, y: Float, z: Float){
        self.position = float3(x, y, z)
    }
    public func move(to newPosition: float3){
        self.position = newPosition
    }
    public func moveX(by delta: Float){
        self.position.x += delta
    }
    public func moveY(by delta: Float){
        self.position.y += delta
    }
    public func moveZ(by delta: Float){
        self.position.z += delta
    }
}

extension Transformable{
	public func rotateX(by angle: Float){
        rotation.x += angle.fromDegrees   
    }
    public func rotateY(by angle: Float){
        rotation.y += angle.fromDegrees
    }
    public func rotateZ(by angle: Float){
        rotation.z += angle.fromDegrees
	 }
}

extension Transformable {
    public func scaleX(by delta: Float){
        scale.x *= delta
    }
    public func scaleY(by delta: Float){
        scale.y *= delta
    }
    public func scaleZ(by delta: Float){
        scale.z *= delta
    }
    public func scaleAll(by delta: Float){
        scaleX(by: delta)
        scaleY(by: delta)
        scaleZ(by: delta)
    }
}
