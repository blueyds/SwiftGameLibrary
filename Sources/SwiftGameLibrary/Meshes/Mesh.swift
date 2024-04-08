import Metal

public protocol Mesh: AnyObject, Nameable{
    func render(using: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState, at: Transformable)
    func drawPrimitives(using: MTLRenderCommandEncoder)
	func assignModel(transforms: Transformable, to: MTLRenderCommandEncoder)
	func setVertices(to: MTLRenderCommandEncoder)
    func setPipelineState(on: MTLRenderCommandEncoder, didChange: inout Bool)
}

extension Mesh{
    public func setVertices(to: MTLRenderCommandEncoder) {}
    public func setPipelineState(on: MTLRenderCommandEncoder, didChange: inout Bool){ didChange = false }
    public func assignModel(transforms: Transformable, to encoder: MTLRenderCommandEncoder){
		encoder.setVertexBytes(&transforms.modelMatrix, length: Matrix.stride(), index: BufferIndex.ModelMatrix)
	}
	
	public func render(using encoder: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState, at transforms: Transformable){
        encoder.pushDebugGroup(name)
        var didChange: Bool = false
        setPipelineState(on: encoder, didChange: &didChange)
        setVertices(to: encoder)
        assignModel(transforms: transforms, to: encoder)
        drawPrimitives(using: encoder)
        if didChange {
            encoder.setRenderPipelineState(currentState)
        }
        encoder.popDebugGroup()
    }

}