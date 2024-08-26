import Metal
import SwiftGameTypes

public class Cube: VertexCollection{
	
	public var vertices: [Vertex] = []
	public var vertexBuffer: MTLBuffer? = nil
	//public var name: String = "CUBE"
	private let colors: [GameColor]
	public init() { 
        colors = [GameColor.random]
        build()
    }
    public init(color: GameColor){
        colors = [color]
        build()
    }
	
	public init(using device: MTLDevice){ 
        colors = [GameColor.random]
        build(using: device)
    }
	
	public func createVertices(){
        if colors.count < 6{
		    createVertices(colors[0])
        } else{
            createLeft(colors[0])
		    createRight(colors[1])
		    createTop(colors[2])
		    createBottom(colors[3])
		    createBack(colors[4])
		    createFront(colors[5])
        }
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
	
	private func createRight(_ color: GameColor){
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