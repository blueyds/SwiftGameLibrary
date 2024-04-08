public class Cube: VertexCollection{
	public let id: Int

	public let name: String 
	
	public let vertices: [Vertex] = []
    
    public init(color: Color){
        id = Int.NextID()
        name = "Cube_" + color.name
        createVertices(color)
    }
    public init(left: Color, right: Color, top: Color, bottom: Color, back: Color, front: Color){
        id = Int.NextID()
        name = "Cube_LEFT" + left.name + 
			"_RIGHT" + right.name +
			"_TOP" + top.name +
			"_BOTTOM" + bottom.name +
			"_BACK" + back.name +	
			"_FRONT" + front.name 
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
      add(vertex: Vertex( float3( 1, -1, 1 ), color))
      add(vertex: Vertex( float3( 1, 1, 1 ), color))
      add(vertex: Vertex( float3( -1, 1, 1 ), color))
      add(vertex: Vertex( float3( 1, -1, 1 ), color))
      
    }
    
}
