import simd

public protocol Transformable: AnyObject{
    var transforms: [Transforms] { get set }
    var matrices: [Matrix] { get set }
}

extension Transformable{
    public func calculateModelMatrix(parent: Matrix = Matrix.identity){
        matrices = []
        transforms.forEach(){ model in
            var result = Matrix.identity
            result.translateModel(model.position)
            result.rotate(model.rotation)
            result.scale(model.scale)
            matrices.append(matrix_multiply(parent, result))
        }
    }
}

extension Transformable{
    public func position(x: Float, y: Float, z: Float, at: Int = 0){
        transforms[at].position = float3(x, y, z)
    }
    public func moveX(by delta: Float, at: Int = 0){
        transforms[at].position.x += delta
    }
    public func moveY(by delta: Float, at: Int = 0){
        transforms[at].position.y += delta
    }
    public func moveZ(by delta: Float, at: Int = 0){
        transforms[at].position.z += delta
    }
}

extension Transformable{
	public func rotateX(by angle: Float, at: Int = 0){
        transforms[at].rotation.x += angle.fromDegrees   
    }
    public func rotateY(by angle: Float, at: Int = 0){
        transforms[at].rotation.y += angle.fromDegrees
    }
    public func rotateZ(by angle: Float, at: Int = 0){
        transforms[at].rotation.z += angle.fromDegrees
	 }
}

extension Transformable {
    public func scaleX(by delta: Float, at: Int = 0){
        transforms[at].scale.x *= delta
    }
    public func scaleY(by delta: Float, at: Int = 0){
        transforms[at].scale.y *= delta
    }
    public func scaleZ(by delta: Float, at: Int = 0){
        transforms[at].scale.z *= delta
    }
    public func scaleAll(by delta: Float, at: Int = 0){
        scaleX(by: delta, at: at)
        scaleY(by: delta, at: at)
        scaleZ(by: delta, at: at)
    }
}

