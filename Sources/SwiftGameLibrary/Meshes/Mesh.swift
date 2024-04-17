import Metal

public protocol Mesh: AnyObject, Nameable{
	func render(with: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState, at: Transformable)
	func drawPrimitives(using: MTLRenderCommandEncoder)
	func assignModel(transforms: Transformable, to: MTLRenderCommandEncoder)
	func setVertices(to: MTLRenderCommandEncoder)
	func setPipelineState(on: MTLRenderCommandEncoder, _ didChange: inout Bool)
}

extension Mesh{
	public func setVertices(to: MTLRenderCommandEncoder) {}
	public func setPipelineState(on: MTLRenderCommandEncoder, _ didChange: inout Bool){ didChange = false }
	public func assignModel(transforms: Transformable, to encoder: MTLRenderCommandEncoder){
		encoder.setVertexBytes(&transforms.modelMatrix, length: Matrix.stride(), index: BufferIndex.ModelMatrix)
	}
	
	public func render(with encoder: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState, at transforms: Transformable){
		encoder.pushDebugGroup(name)
		var didChange: Bool = false
		setPipelineState(on: encoder, &didChange)
		setVertices(to: encoder)
		assignModel(transforms: transforms, to: encoder)
		drawPrimitives(using: encoder)
		if didChange {
			encoder.setRenderPipelineState(currentState)
		}
		encoder.popDebugGroup()
	}
}