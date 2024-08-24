import Metal
import simd
import SwiftGameTypes

public class CameraNode: GameNode {
	public let id: Int = Int.NextID()

	public var transforms: Transformable = Transformable()

	public var children: [any GameNode] = []

	public var viewport: (width: Float, height: Float)
	
	public init(named name: String, width: Float, height: Float){
		self.viewport = (width: width, height: height)
	}
	
	open func getViewMatrix()->Matrix{ 
		calculateViewMatrix()
	}
	open func getProjectionMatrix()->Matrix { Matrix.identity }

	open func viewportDidChange() { }
	
	func changeViewportSize(to newSize: (width: Float, height: Float)){
		self.viewport = newSize
		viewportDidChange()
	}
		
	internal func calculateViewMatrix()->Matrix{
		var result = Matrix.identity
		result.translateModel(-transforms.position)
		result.rotate(-transforms.rotation)
		//result.scale(scale)
		return result
	}
}
