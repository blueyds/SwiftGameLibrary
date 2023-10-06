public class Cube: CustomMesh{
    public override func createVertices(r: Float, g: Float, b: Float, a: Float) {
        
    }
    private func creatLeft(r: Float, g: Float, b: Float, a: Float){
      //Left
      let vert = [
            Vertex(x: -1, y: -1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: -1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: 1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: -1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: 1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: 1, z: -1, r: r, g: g, b: b, a: a)
            ]
            vertices.append(vert)
    }
    private func createRight(r: Float, g: Float, b: Float, a: Float){
    // Right
    let vert = [
            Vertex(x: 1, y: 1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: -1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: 1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: -1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: 1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: -1, z: 1, r: r, g: g, b: b, a: a)
            ]
             vertices.append(vert)
    }
    private func createTop(r: Float, g: Float, b: Float, a: Float){
    //top
            let vert = [
            Vertex(x: 1, y: 1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: 1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: 1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: 1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: 1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: 1, z: 1, r: r, g: g, b: b, a: a)
            ]
            vertices.append(vert)
    }
    private func createBottom(r: Float, g: Float, b: Float, a: Float){
    //bottom
    let vert = [
            Vertex(x: 1, y: -1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: -1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: -1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: -1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: -1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: -1, z: -1, r: r, g: g, b: b, a: a)
            ]
            vertices.append(vert)
    }
    private func createBack(r: Float, g: Float, b: Float, a: Float){
    //back
    let vert = [
            Vertex(x: 1, y: 1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: -1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: 1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: 1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: -1, z: -1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: -1, z: -1, r: r, g: g, b: b, a: a)
            ]
            vertices.append(vert)
    }
    private func createFront(r: Float, g: Float, b: Float, a: Float){
    //front
        let vert = [
            Vertex(x: -1, y: 1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: -1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: -1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: 1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: -1, y: 1, z: 1, r: r, g: g, b: b, a: a),
            Vertex(x: 1, y: -1, z: 1, r: r, g: g, b: b, a: a)
        ]
        vertices.append(vert)
    }
    public init(position: float4, left: Color, right: Color, top: Color, botton: Color, back: Color, front: Color){
            self.name = named
            position(x: x, y: y, z: z)
            createLeft(r: left.r, g: left.g, b: left.b, a: left.a)
            createRight(r: right.r, g: right.g, b: right.b, a: right.a)
            createTop(r: top.r, g: top.g, b: top.b, a: top.a)
            createBottom(r: bottom.r, g: bottom.g, b: bottom.b, a: botton.a)
            createBack(r: back.r, g: back.g, b: back.b, a: back.a)
            createFront(r: front.r, g: front.g, b: front.b, a: front.a)
    }
}
