/*
public class Pyramid: VertexCollection{
    
    public init(color: Color){
        super.init(named: "PYRAMID_" + color.name)
        createVertices(color)
		finishedBuilding()
    }
    public init(left: Color, right: Color,  back: Color, front: Color, bottom: Color){
        let name = "PYRAMID_LEFT" + left.name + 
        "_RIGHT" + right.name +
        "_BOTTOM" + bottom.name +
        "_BACK" + back.name +    
        "_FRONT" + front.name 
		super.init(named: name)
        createLeft(left)
        createRight(right)
        createBack(back)
        createFront(front)
        createBottom(bottom)
		finishedBuilding()
    }
    
    public  func createVertices(_ color: Color) {
        
        createLeft(color)
        createRight(color)
        createBack(color)
        createFront(color)
        createBottom(color)
    }
	private func addTop(_ color: Color){
		add(0, 1, 0, color)
	}
    private func createLeft(_ color: Color){
        add(vertex: Vertex( float3( -1, -1, -1), color))
        addTop(color)
        add(vertex: Vertex( float3( -1, -1, 1), color))
    }
    
    private func createRight(_ color: Color){
        // Right
        add(vertex: Vertex( float3( 1, -1, -1 ), color))
        addTop(color)
        add(vertex: Vertex( float3( 1, -1, 1 ), color))
    }
    private func createBack(_ color: Color){
        //back
        add(vertex: Vertex( float3( -1, -1, -1 ), color))
        addTop(color)
        add(vertex: Vertex( float3( 1, -1, -1 ), color))
    }
    private func createFront(_ color: Color){
        //front
        add(vertex: Vertex( float3( -1, -1, 1 ), color))
        addTop(color)
        add(vertex: Vertex( float3( 1, -1, 1 ), color))
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
	
}*/

