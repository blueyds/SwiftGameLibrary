import Metal
import simd

public protocol Camera: AnyObject, Transformable, Nameable {
	func getViewMatrix()->Matrix
	func getProjectionMatrix()->Matrix
	
	func changeAspectRatio(_ : Float)
	func update(counter: TickCounter)
	
}

extension Camera {
	public func getViewMatrix()->Matrix{ Matrix.identity }
	public func getProjectionMatrix()->Matrix { Matrix.identity }
    
	public func changeAspectRatio(_ ratio: Float){ }

	public func changeAspectRatio(width: Float, height: Float){
		changeAspectRatio(width / height)
	}
	
	public func update(counter ticks: TickCounter){ }
	
	
	public func calculateViewMatrix()->Matrix{
		var result = Matrix.identity
		result.translateModel(-position)
		result.rotate(-rotation)
		//result.scale(scale)
		return result
	}
}