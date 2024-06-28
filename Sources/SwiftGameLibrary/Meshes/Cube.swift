import Metal

public class Cube: VertexCollection{
	
	public var vertices: [Vertex] = []
	public var vertexBuffer: MTLBuffer? = nil
	//public var name: String = "CUBE"
	public init() { build() }
	public init(using device: MTLDevice){ build(using: device)}
    
	public func getBoundingBox(center: SIMD3<Float>,scaledBy: SIMD3<Float>)->AABB{
		// we can use extant version bercause the unscaled Cube is 2 X 2 X 2
		AxisAlignedBoundingBox(worldPos: center, extantX: scaledBy.x, extantY: scaledBy.y, extantZ: scaledBy.z)
	}
	
	public func createVertices(){
		createVertices(.random)
	}
	
	public  func createVertices(_ color: Color) {
		createLeft(color)
		createRight(color)
		createTop(color)
		createBottom(color)
		createBack(color)
		createFront(color)
	}
	
	private func createLeft(_ color: Color){
		// Left
		add( -1, -1, -1, color)
		add( -1, -1,  1, color)
		add( -1,  1,  1, color)
		add( -1, -1, -1, color)
		add( -1,  1,  1, color)
		add( -1,  1, -1, color)
	}
	
	private func createRight(_ color: Color){
		// Right
		add( 1,  1,  1, color)
		add( 1, -1, -1, color)
		add( 1,  1, -1, color)
		add( 1, -1, -1, color)
		add( 1,  1,  1, color)
		add( 1, -1,  1, color)
	}
	
	private func createTop(_ color: Color){
		//top
		add(  1, 1,  1, color)
		add(  1, 1, -1, color)
		add( -1, 1, -1, color)
		add(  1, 1,  1, color)
		add( -1, 1, -1, color)
		add( -1, 1,  1, color)
	}
	private func createBottom(_ color: Color){
		//bottom
		add(  1, -1,  1, color)
		add( -1, -1, -1, color)
		add(  1, -1, -1, color)
		add(  1, -1,  1, color)
		add( -1, -1,  1, color)
		add( -1, -1, -1, color)
	}
	private func createBack(_ color: Color){
		//back
		add(  1,  1, -1, color)
		add( -1, -1, -1, color)
		add( -1,  1, -1, color)
		add(  1,  1, -1, color)
		add(  1, -1, -1, color)
		add( -1, -1, -1, color)
	}
	private func createFront(_ color: Color){
		//front
		add( -1,  1, 1, color)
		add( -1, -1, 1, color)
		add(  1, -1, 1, color)
		add(  1,  1, 1, color)
		add( -1,  1, 1, color)
		add(  1, -1, 1, color)
	}
}