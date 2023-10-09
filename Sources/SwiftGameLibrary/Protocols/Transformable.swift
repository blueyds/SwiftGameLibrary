import simd

public protocol Transformable: AnyObject{
    var transforms: Transforms { get set }
}

extension Transformable{
    public func calculateModelMatrix(parent: Matrix = Matrix.identity){
        var result = Matrix.identity
        result.translateModel(transforms.position)
        result.rotate(transforms.rotation)
        result.scale(transforms.scale)
        transforms.matrix = matrix_multiply(parent, result)
    }
}

extension Transformable{
    public func position(x: Float, y: Float, z: Float){
        moveX(by: x)
        moveY(by: y)
        moveZ(by: z)
    }
    public func moveX(by delta: Float){
        transforms.position.x += delta
    }
    public func moveY(by delta: Float){
        transforms.position.y += delta
    }
    public func moveZ(by delta: Float){
        transforms.position.z += delta
    }
}

extension Transformable{
	public func rotateX(by angle: Float){
        transforms.rotation.x += angle.fromDegrees   
    }
    public func rotateY(by angle: Float){
        transforms.rotation.y += angle.fromDegrees
    }
    public func rotateZ(by angle: Float){
        transforms.rotation.z += angle.fromDegrees
	 }
}

extension Transformable {
    public func scaleX(by delta: Float){
        transforms.scale.x *= delta
    }
    public func scaleY(by delta: Float){
        transforms.scale.y *= delta
    }
    public func scaleZ(by delta: Float){
        transforms.scale.z *= delta
    }
    public func scaleAll(by delta: Float){
        scaleX(by: delta)
        scaleY(by: delta)
        scaleZ(by: delta)
    }
}

