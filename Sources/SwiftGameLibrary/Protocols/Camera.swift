import Metal
import simd

public protocol Camera: Renderable {
    var viewMatrix: Matrix { get }
    var projectionMatrix: Matrix { get }
}

extension Camera {
    public func render(using encoder: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState){
        var view: Matrix = viewMatrix
        var projection: Matrix = projectionMatrix
        encoder.setVertexBytes(&view, length: Matrix.stride(), index: BufferIndex.ViewMatrix)
        encoder.setVertexBytes(&projection, length: Matrix.stride(), index: BufferIndex.ProjectionMatrix)
    }
}