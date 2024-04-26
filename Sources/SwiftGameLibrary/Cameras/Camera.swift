import Metal
import simd

public protocol Camera: AnyObject, Transformable, Nameable {
	var viewMatrix: Matrix { get set }
	var projectionMatrix: Matrix { get set }
	func getViewMatrix()->Matrix
	func getProjectionMatrix()->Matrix
	func render(with: MTLRenderCommandEncoder)
	func changeAspectRatio(_ : Float)
	func update(counter: TickCounter)
	
}

extension Camera {
	public func getViewMatrix()->Matrix{ Matrix.identity }
	public func getProjectionMatrix()->Matrix { Matrix.identity }
    public func render(with encoder: MTLRenderCommandEncoder){
		var view: Matrix = getViewMatrix()
		var projection: Matrix = getProjectionMatrix()
		encoder.pushDebugGroup("Camera \(name)")
		encoder.setVertexBytes(&view, length: Matrix.stride(), index: BufferIndex.ViewMatrix)
		encoder.setVertexBytes(&projection, length: Matrix.stride(), index: BufferIndex.ProjectionMatrix)
		encoder.popDebugGroup()
	}
	public func changeAspectRatio(_ ratio: Float){ }

	public func changeAspectRatio(width: Float, height: Float){
		changeAspectRatio(width / height)
	}
	
	public func update(counter ticks: TickCounter){ }
}