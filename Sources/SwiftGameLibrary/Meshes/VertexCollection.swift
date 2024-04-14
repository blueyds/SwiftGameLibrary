import Metal

public class VertexCollection: Mesh{
    // var vertexBuffer: MTLBuffer! { get set }
    private var vertices: [Vertex] = []
	public let name: String
	private var _vertexBuilder: VertexCollectionBuilder? = nil
	public init(named name: String){
		self.name = name
	}
    //    func createVertices()
    //    func createBuffer()
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
		checkBuilder()
		_vertexBuilder!.add(vertex)
	}
	private func checkBuilder(){
		if _vertexBuilder == nil {
			_vertexBuilder = VerticeCollectionBuilder()
		}
	}
	public func add(x: Float, y: Float, z: Float, r: Float, g: Float, b: Float, a: Float){
		checkBuilder()
		_vertexBuilder!.add(x, y, z, r, g, b, a)	
	}
	public func finishedBuilding(){
		if _vertexBuilder == nil {
			fatalError("called finish too early \(self)")
		}
		vertices = _vertexBuilder.getProcessedVertexData()
		_vertexBuilder = nil
		print(vertices)
	}
}

