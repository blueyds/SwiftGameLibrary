import simd

public protocol Transformable: AnyObject{
    var position: SIMD3<Float> { get set }
    var rotation: SIMD3<Float> { get set }
    var scale: SIMD3<Float> { get set}
   // var modelMatrix: Matrix { get set}
}

extension Transformable{
	internal func calculateModelMatrix(_ parentMatrix: Matrix = Matrix.identity)->Matrix{
		var result = Matrix.identity
		result.translateModel(position)
		result.rotate(rotation)
		result.scale(scale)
		return matrix_multiply(parentMatrix, result)
	}
}

extension Transformable{
    public func moveTo(x: Float, y: Float, z: Float){
        self.position = SIMD3<Float>(x, y, z)
    }
    public func move(to newPosition: SIMD3<Float>){
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
