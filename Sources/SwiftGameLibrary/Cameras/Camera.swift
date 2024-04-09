import Metal
import simd

public protocol Camera: AnyObject, Transformable, Nameable {
    var viewMatrix: Matrix { get }
    var projectionMatrix: Matrix { get }
    func render(using: MTLRenderCommandEncoder)
	func changeAspectRatio(_ : Float)
	func update(counter: TickCounter)
	
}

extension Camera {
	
    public func render(with encoder: MTLRenderCommandEncoder){
        var view: Matrix = viewMatrix
        var projection: Matrix = projectionMatrix
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