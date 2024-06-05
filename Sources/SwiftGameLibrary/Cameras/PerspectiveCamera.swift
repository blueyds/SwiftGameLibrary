import simd

public class PerspectiveCamera: CameraNode{
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
	
	public init(named: String, origin: SIMD3<Float>, fov: Float = 90, aspectRatio: Float = 1, near: Float = 1, far: Float = 1000 ){
		self.position = origin
		self.name = named
		self.fov = fov
		self.aspectRatio = aspectRatio
		self.near = near
		self.far = far
		super.init(named: named)
	}
	public func changeAspectRatio(_ ratio: Float){
		self.aspectRatio = ratio
	}
}
