public protocol Camera: Renderable {
    var viewMatrix: Matrix { get }
    var projectionMatrix: Matrix { get }
}

extension Camera {
    public func render(using: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState){
        encoder.setVertexBytes(&viewMatrix, length: Matrix.stride(), index: BufferIndex.ViewMatrix)
        encoder.setVertexBytes(&projectionMatrix, length: Matrix.stride(), index: BufferIndex.ProjectionMatrix)
    }
}