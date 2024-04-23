import Metal
public class Pyramid: VertexCollection{
    public var vertices: [Vertex] = []
	public var vertexBuffer: MTLBuffer? = nil
	public var name: String = "PYRAMID"
	public init() { build() }
	public init(using device: MTLDevice){ build(using: device)}
    public func createVertices(){
		createVertices(.random)
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
        add(-1, -1, -1, color)
        addTop(color)
        add( -1, -1, 1, color)
    }
    
    private func createRight(_ color: Color){
        // Right
        add(1, -1, -1, color)
        addTop(color)
        add(1, -1, 1, color)
    }
    private func createBack(_ color: Color){
        //back
        add(-1, -1, -1, color)
        addTop(color)
        add(1, -1, -1, color)
    }
    private func createFront(_ color: Color){
        //front
        add(-1, -1, 1, color)
        addTop(color)
        add(1, -1, 1, color)
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
	
}

