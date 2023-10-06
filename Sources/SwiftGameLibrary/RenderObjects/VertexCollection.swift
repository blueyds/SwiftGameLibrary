import Metal

public protocol VertexCollection: Renderable{
    // var vertexBuffer: MTLBuffer! { get set }
    var vertices: [Vertex] { get }
    //    func createVertices()
    //    func createBuffer()
}
extension VertexCollection{
    public var vertexCount: Int{
        vertices.count
    }
	public func render(using encoder: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState) {
		encoder.setVertexBytes(vertices, length: Vertex.stride(of: vertexCount), index: BufferIndex.Vertex)
        encoder.setVertexBytes(&transforms.matrix, length: Matrix.stride(), index: BufferIndex.ModelMatrix)
		encoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount)
	}
}
