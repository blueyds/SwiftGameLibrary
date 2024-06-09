import Metal
import simd

public class CameraNode: GameNode {
	public var viewport: (width: Float, height: Float)
	
	public init(named name: String){
		self.viewport = (width: 0, height: 0)
		super.init(named: name)
	}
	
	open func getViewMatrix()->Matrix{ 
		calculateViewMatrix()
	}
	open func getProjectionMatrix()->Matrix { Matrix.identity }

	open func viewportDidChange() { }
	
	func changeViewportSize(to newSize: (width: Float, height: Float){
		self.viewport = newSize
		viewportDidChange()
	}
		
	public func calculateViewMatrix()->Matrix{
		var result = Matrix.identity
		result.translateModel(-position)
		result.rotate(-rotation)
		//result.scale(scale)
		return result
	}
}