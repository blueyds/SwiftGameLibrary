import simd

public class PerspectiveCamera: CameraNode{
	var fov: Float
	var aspectRatio: Float
	var near: Float
	var far: Float
	
	override public func getProjectionMatrix()->Matrix {
		Matrix.perspective(degreesFov: fov, aspectRatio: aspectRatio, nearZ: near, farZ: far)
	}
	
	public init(named: String, origin: SIMD3<Float>, fov: Float = 90, aspectRatio: Float = 1, near: Float = 1, far: Float = 1000 ){
		self.fov = fov
		self.aspectRatio = aspectRatio
		self.near = near
		self.far = far

		super.init(named: named, width: 1, height: 1)

		transforms.position = origin
	}
	override public func  viewportDidChange(){
		self.aspectRatio = viewport.width / viewport.height
	}
}
