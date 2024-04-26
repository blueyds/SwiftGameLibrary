import simd

public class PerspectiveCamera: Camera, Identifiable{
	public let name: String
	public let id: Int = Int.NextID()
	public var position: SIMD3<Float> = .zero
	public var rotation: SIMD3<Float> = .zero
	public var scale: SIMD3<Float> = .one
	 var fov: Float
	 var aspectRatio: Float
	 var near: Float
	 var far: Float
	public func getViewMatrix()->Matrix{
		calculateViewMatrix()
	}
	public func getProjectionMatrix()->Matrix {
		Matrix.perspective(degreesFov: fov, aspectRatio: aspectRatio, nearZ: near, farZ: far)
	}
	
	public init(named: String){
		self.name = named
		self.fov = 90
		self.aspectRatio = 1
		self.near = 1
		self.far = 1000
	}
	public init(named: String, origin: SIMD3<Float>, fov: Float, aspectRatio: Float, near: Float, far: Float ){
		self.position = origin
		self.name = named
		self.fov = fov
		self.aspectRatio = aspectRatio
		self.near = near
		self.far = far
	}
	public func changeAspectRatio(_ ratio: Float){
		self.aspectRatio = ratio
	}
}
