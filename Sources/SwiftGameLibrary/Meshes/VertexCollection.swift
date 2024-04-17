import Metal
import SwiftGameLibrary
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
            _vertexBuilder = VertexCollectionBuilder()
        }
    }
    public func add(_ x: Float, _ y: Float, _ z: Float, _ r: Float, _ g: Float, _ b: Float, _ a: Float){
        let v = Vertex(float3(x,y,z), Color(r,g,b,a))
        add(vertex: v)    
    }
    public func add(_ x: Float,_ y: Float,_ z: Float, _ color: Color){
        let v = Vertex(float3(x,y,z), color)
        add(vertex: v)
    }
    public func finishedBuilding(){
        if _vertexBuilder == nil {
            fatalError("called finish too early \(self)")
        }
        //print("getting process vertexd data")
        vertices = _vertexBuilder!.getProcessedVertexData()
        //print("Finished proceess vertex data")
        _vertexBuilder = nil
        
    }
}