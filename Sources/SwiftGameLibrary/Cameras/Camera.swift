import Metal
import simd

public class CameraNode: GameNode {
	open func getViewMatrix()->Matrix{ Matrix.identity }
	open func getProjectionMatrix()->Matrix { Matrix.identity }
    
	open func changeAspectRatio(_ ratio: Float){ }

	open func changeAspectRatio(width: Float, height: Float){
		changeAspectRatio(width / height)
	}
		
	public func calculateViewMatrix()->Matrix{
		var result = Matrix.identity
		result.translateModel(-position)
		result.rotate(-rotation)
		//result.scale(scale)
		return result
	}
}