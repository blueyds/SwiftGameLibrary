import SwiftGameLibrary

public class Triangle: CustomMesh{
	public override func createVertices(r: Float, g: Float, b: Float, a: Float) {
		vertices = [
			Vertex(x: 0, y: 1, z: 0 , r: r, g: g, b: b, a: a),
			Vertex(x: -1, y: -1, z: 0, r: r, g: g, b: b, a: a),
			Vertex(x: 1, y: -1, z: 0, r: r, g: g, b: b, a: a)
		]
	}

}
