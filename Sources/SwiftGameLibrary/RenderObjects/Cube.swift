public class Cube: CustomMesh{
    public override func createVertices(r: Float, g: Float, b: Float, a: Float) {
        vertices = [
            //Left
            Vertex(x: -1, y: -1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: -1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: 1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: -1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: 1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: 1, z: -1, r: r, g: g, b: b, a: a),
            // Right
            Vertex(x: 1, y: 1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: -1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: 1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: -1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: 1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: -1, z: 1, r: r, g: g, b: b, a: a),
            //top
            Vertex(x: 1, y: 1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: 1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: 1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: 1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: 1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: 1, z: 1, r: r, g: g, b: b, a: a),
            //bottom
            Vertex(x: 1, y: -1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: -1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: -1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: -1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: -1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: -1, z: -1, r: r, g: g, b: b, a: a),
            //back
            Vertex(x: 1, y: 1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: -1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: 1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: 1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: -1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: -1, z: -1, r: r, g: g, b: b, a: a),
            //front
            Vertex(x: -1, y: 1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: -1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: -1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: 1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: 1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: -1, z: 1, r: r, g: g, b: b, a: a)
        ]
    }
}
