
public protocol Transformable: AnyObject{
    public var position: float3 { get set }
    public var rotation: float3 { get set }
    public var scale: float3 { get set}
    public var modelMatrix: Matrix { get set}
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
    public func position(x: Float, y: Float, z: Float, at: Int = 0){
        position = float3(x, y, z)
    }
    public func move(to position: float3, at: Int = 0){
        position = position
    }
    public func moveX(by delta: Float, at: Int = 0){
        position.x += delta
    }
    public func moveY(by delta: Float, at: Int = 0){
        position.y += delta
    }
    public func moveZ(by delta: Float, at: Int = 0){
        position.z += delta
    }
}

extension Transformable{
	public func rotateX(by angle: Float, at: Int = 0){
        rotation.x += angle.fromDegrees   
    }
    public func rotateY(by angle: Float, at: Int = 0){
        rotation.y += angle.fromDegrees
    }
    public func rotateZ(by angle: Float, at: Int = 0){
        rotation.z += angle.fromDegrees
	 }
}

extension Transformable {
    public func scaleX(by delta: Float, at: Int = 0){
        scale.x *= delta
    }
    public func scaleY(by delta: Float, at: Int = 0){
        scale.y *= delta
    }
    public func scaleZ(by delta: Float, at: Int = 0){
        scale.z *= delta
    }
    public func scaleAll(by delta: Float, at: Int = 0){
        scaleX(by: delta, at: at)
        scaleY(by: delta, at: at)
        scaleZ(by: delta, at: at)
    }
}
