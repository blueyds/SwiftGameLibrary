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
	public func drawPrimitives(using encoder: MTLRenderCommandEncoder) {
		encoder.setVertexBytes(vertices, length: Vertex.stride(at: vertexCount), index: BufferIndex.Vertex)
		encoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount)
	}
}
