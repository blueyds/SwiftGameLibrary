import Metal

public protocol SimpleCustomMesh: Renderable{
    // var vertexBuffer: MTLBuffer! { get set }
    var vertices: [Vertex] { get }
    //    func createVertices()
    //    func createBuffer()
}
extension SimpleCustomMesh{
    public var vertexCount: Int{
        vertices.count
    }
	public func drawPrimitives(using encoder: MTLRenderCommandEncoder) {
		encoder.setVertexBytes(vertices, length: vertexCount * Vertex.stride(), index: 0)
		encoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount)
	}
}
