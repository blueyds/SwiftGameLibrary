import Metal

public protocol VertexCollection: Mesh{
    // var vertexBuffer: MTLBuffer! { get set }
    var vertices: [Vertex] { get set }
    //    func createVertices()
    //    func createBuffer()
}
extension VertexCollection{	
    public var vertexCount: Int{
        vertices.count
    }
    public func setVertices(to encoder: MTLRenderCommandEncoder){
    	encoder.setVertexBytes(vertices, length: Vertex.stride(of: vertexCount), index: BufferIndex.Vertex)
    }
    public func drawPrimitives(using encoder: MTLRenderCommandEncoder){
    	encoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount)
    }
    
	public func add(vertex: Vertex){
		vertices.append(vertex)
	}
}