import Metal

public protocol Mesh: AnyObject{
	func render(with: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState, modelMatrix: Matrix)
	func drawPrimitives(using: MTLRenderCommandEncoder)
	func assign(modelMatrix: Matrix, to: MTLRenderCommandEncoder)
	func setVertices(to: MTLRenderCommandEncoder)
	func setPipelineState(on: MTLRenderCommandEncoder, _ didChange: inout Bool)
}

extension Mesh{
	public func setVertices(to: MTLRenderCommandEncoder) {}
	public func setPipelineState(on: MTLRenderCommandEncoder, _ didChange: inout Bool){ didChange = false }
	public func assign(modelMatrix: Matrix, to encoder: MTLRenderCommandEncoder){
		var matrix: Matrix = modelMatrix
		encoder.setVertexBytes(&matrix, length: Matrix.stride(), index: BufferIndex.ModelMatrix)
	}
	
	public func render(with encoder: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState, modelMatrix: Matrix){
		var didChange: Bool = false
		setPipelineState(on: encoder, &didChange)
		setVertices(to: encoder)
		assign(modelMatrix: modelMatrix, to: encoder)
		drawPrimitives(using: encoder)
		if didChange {
			encoder.setRenderPipelineState(currentState)
		}
	}
}