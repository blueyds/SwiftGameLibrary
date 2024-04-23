import Metal
import simd
public protocol VertexCollection: Mesh{
	var vertices: [Vertex] { get set}
	var vertexBuffer: MTLBuffer? { get set }
	func createVertices() 
}
extension VertexCollection{
	public init(){
		createVertices()
		vertexBuffer = nil
	}
	public init(using device: MTLDevice){
		createVertices()
		createBuffer(using: device)
	}
	
	private func createBuffer(using device: MTLDevice){
		if  vertices.count >  0{
			vertexBuffer = device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
		}
	}
	public func setVertices(to encoder: MTLRenderCommandEncoder){
		if vertexBuffer == nil {
			encoder.setVertexBytes(vertices, length: Vertex.stride(of: vertices.count), index: BufferIndex.Vertex)
		} else {
			encoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
		}
	}
	public func drawPrimitives(using encoder: MTLRenderCommandEncoder){
        encoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount)
    }

	public func add(vertex: Vertex){
		vertices.append(vertex)
	}
	
	public func add(_ x: Float, _ y: Float, _ z: Float, _ r: Float, _ g: Float, _ b: Float, _ a: Float){
		let v = Vertex(SIMD3<Float>(x,y,z), Color(r,g,b,a))
		add(vertex: v)    
	}
	public func add(_ x: Float,_ y: Float,_ z: Float, _ color: Color){
		let v = Vertex(SIMD3<Float>(x,y,z), color)
		add(vertex: v)
	}
}