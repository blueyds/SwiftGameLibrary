public class Cube: GameNode, VertexCollection{
    	public var id = Int.NextID()

	public var name: String
	
	//public var parent: (any GameNode)?

	public var children: [any GameNode] = []

	public var transforms = Transforms()
    
	public var vertices: [Vertex] = []
    public init(named: String, position: float3, color: Color){
        self.name = named
        transforms.position = position
        createVertices(color)
    }
    public init(named: String, position: float3, left: Color, right: Color, top: Color, bottom: Color, back: Color, front: Color){
        self.name = named
        transforms.position = position
            createLeft(left)
            createRight(right)
            createTop(top)
            createBottom(bottom)
            createBack(back)
            createFront(front)
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
      // TODO: rewrite all calls like the add vertex below. this shouldelaimate other err
      add(vertex: Vertex( float3( -1, -1, -1), color))
      add(vertex: Vertex( float3( -1, -1, 1), color))
      add(vertex: Vertex( float3( -1, 1, 1), color))
      add(vertex: Vertex( float3( -1, -1, -1), color))
      add(vertex: Vertex( float3( -1, 1, 1), color))
      add(vertex: Vertex( float3( -1, 1, -1), color))
      
    }
    private func createRight(_ color: Color){
        // Right
      add(vertex: Vertex( float3( 1, 1, 1 ), color))
      add(vertex: Vertex( float3( 1, -1, -1 ), color))
      add(vertex: Vertex( float3( 1, 1, -1 ), color))
      add(vertex: Vertex( float3(  1, -1, -1), color))
      add(vertex: Vertex( float3( 1, 1, 1 ), color))
      add(vertex: Vertex( float3( 1, -1, 1 ), color))
    
    }
    private func createTop(_ color: Color){
        //top
      add(vertex: Vertex( float3( 1, 1, 1  ), color))
      add(vertex: Vertex( float3( 1, 1, -1), color))
      add(vertex: Vertex( float3( -1, 1, -1 ), color))
      add(vertex: Vertex( float3( 1, 1, 1 ), color))
      add(vertex: Vertex( float3( -1, 1, -1 ), color))
      add(vertex: Vertex( float3( -1, 1, 1 ), color))
      
    }
    private func createBottom(_ color: Color){
    //bottom
      add(vertex: Vertex( float3( 1, -1, 1 ), color))
      add(vertex: Vertex( float3( -1, -1, -1 ), color))
      add(vertex: Vertex( float3( 1, -1, -1 ), color))
      add(vertex: Vertex( float3( 1, -1, 1 ), color))
      add(vertex: Vertex( float3( -1, -1, 1 ), color))
      add(vertex: Vertex( float3( -1, -1, -1 ), color))
    }
    private func createBack(_ color: Color){
        //back
      add(vertex: Vertex( float3( 1, 1, -1 ), color))
      add(vertex: Vertex( float3( -1, -1, -1 ), color))
      add(vertex: Vertex( float3( -1, 1, -1 ), color))
      add(vertex: Vertex( float3( 1, 1, -1 ), color))
      add(vertex: Vertex( float3(  1, -1, -1), color))
      add(vertex: Vertex( float3( -1, -1, -1 ), color))
      
    }
    private func createFront(_ color: Color){
    //front
      add(vertex: Vertex( float3( -1, 1, 1 ), color))
      add(vertex: Vertex( float3( -1, -1, 1 ), color))
      add(vertex: Vertex( float3( 1, -1, -1 ), color))
      add(vertex: Vertex( float3( 1, 1, 1 ), color))
      add(vertex: Vertex( float3( -1, 1, 1 ), color))
      add(vertex: Vertex( float3( 1, -1, -1 ), color))
      
    }
    
}
