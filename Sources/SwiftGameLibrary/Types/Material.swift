import simd

public struct Material{
	
	public var color: SIMD4<Float> = Color.random.vector
	
	public var ambient: SIMD3<Float> = .one
	public var diffuse: SIMD3<Float> = .one
	public var specular: SIMD3<Float> = .one
	public var shininess: Float = 1
}