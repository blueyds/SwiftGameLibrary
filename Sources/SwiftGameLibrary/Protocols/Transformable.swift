import simd

public struct Transformable{

	public var position: SIMD3<Float> = .zero
	public var rotation: SIMD3<Float> = .zero
	public var scale: SIMD3<Float> = .one
	public var modelMatrix: Matrix = .identity

	public var normalMatrix: simd_float3x3 {
		let mVM = simd_float3x3(modelMatrix[0].xyz,
								modelMatrix[1].xyz,
								modelMatrix[2].xyz)
		return mVM.inverse.transpose
	}

	public var worldPos: SIMD3<Float>{
		modelMatrix.xyz
	}
}

extension Transformable{

	internal mutating func calculateModelMatrix(_ parentMatrix: Matrix = Matrix.identity){
		var result = Matrix.identity
		result.translateModel(position)
		result.rotate(rotation)
		result.scale(scale)
		modelMatrix = matrix_multiply(parentMatrix, result)
	}
}

extension Transformable{
	public mutating func moveTo(x: Float, y: Float, z: Float){
		position = SIMD3<Float>(x, y, z)
	}
    
	public mutating func move(to newPosition: SIMD3<Float>){
		position = newPosition
	}
    
	public mutating func moveX(by delta: Float){ position.x += delta }
	public mutating func moveY(by delta: Float){ position.y += delta }
	public mutating func moveZ(by delta: Float){ position.z += delta }
}

extension Transformable{
	public mutating func rotateX(byDegrees angle: Float){
		rotation.x += angle.fromDegrees   
	}
    
	public mutating func rotateY(byDegrees angle: Float){
		rotation.y += angle.fromDegrees
	}
    
	public mutating func rotateZ(byDegrees angle: Float){
		rotation.z += angle.fromDegrees
	 }
}

extension Transformable {
	public mutating func scaleX(by delta: Float){
		scale.x *= delta
	}
    
	public mutating func scaleY(by delta: Float){
		scale.y *= delta
	}
    
	public mutating func scaleZ(by delta: Float){
		scale.z *= delta
	}
    
	public mutating func scaleAll(by delta: Float){
		scaleX(by: delta)
		scaleY(by: delta)
		scaleZ(by: delta)
	}
}
