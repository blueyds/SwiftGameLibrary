import Metal

public class Cube: VertexCollection{
	
	public var vertices: [Vertex] = []
	public var vertexBuffer: MTLBuffer? = nil
	//public var name: String = "CUBE"
	
	public init() { build() }
	
	public init(using device: MTLDevice){ build(using: device)}
	
	public func createVertices(){
		createVertices(.random)
	}
	
	public  func createVertices(_ color: GameColor) {
		createLeft(color)
		createRight(color)
		createTop(color)
		createBottom(color)
		createBack(color)
		createFront(color)
	}
	
	private func createLeft(_ color: GameColor){
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
	
	private func createTop(_ color: GameColor){
		//top
		add(  1, 1,  1, color)
		add(  1, 1, -1, color)
		add( -1, 1, -1, color)
		add(  1, 1,  1, color)
		add( -1, 1, -1, color)
		add( -1, 1,  1, color)
	}
	
	private func createBottom(_ color: GameColor){
		//bottom
		add(  1, -1,  1, color)
		add( -1, -1, -1, color)
		add(  1, -1, -1, color)
		add(  1, -1,  1, color)
		add( -1, -1,  1, color)
		add( -1, -1, -1, color)
	}
	
	private func createBack(_ color: GameColor){
		//back
		add(  1,  1, -1, color)
		add( -1, -1, -1, color)
		add( -1,  1, -1, color)
		add(  1,  1, -1, color)
		add(  1, -1, -1, color)
		add( -1, -1, -1, color)
	}
	
	private func createFront(_ color: GameColor){
		//front
		add( -1,  1, 1, color)
		add( -1, -1, 1, color)
		add(  1, -1, 1, color)
		add(  1,  1, 1, color)
		add( -1,  1, 1, color)
		add(  1, -1, 1, color)
	}
	
}