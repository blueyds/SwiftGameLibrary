public class Cube: CustomMesh{
    public override func createVertices(r: Float, g: Float, b: Float, a: Float) {
        createLeft(r: r, g: g, b: b, a: a)
        createRight(r: r, g: g, b: b, a: a)
        createTop(r: r, g: g, b: b, a: a)
        createBottom(r: r, g: g, b: b, a: a)
        createBack(r: r, g: g, b: b, a: a)
        createFront(r: r, g: g, b: b, a: a)
    }
    private func createLeft(r: Float, g: Float, b: Float, a: Float){
      // TODO: rewrite all calls like the add vertex below. this shouldelaimate other err
        add(vertex: Vertex(x: -1, y: -1, z: -1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: -1, y: -1, z: 1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: -1, y: 1, z: 1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: -1, y: -1, z: -1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: -1, y: 1, z: 1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: -1, y: 1, z: -1, r: r, g: g, b: b, a: a))
    }
    private func createRight(r: Float, g: Float, b: Float, a: Float){
        // Right
        add(vertex: Vertex(x: 1, y: 1, z: 1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: 1, y: -1, z: -1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: 1, y: 1, z: -1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: 1, y: -1, z: -1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: 1, y: 1, z: 1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: 1, y: -1, z: 1, r: r, g: g, b: b, a: a))
    }
    private func createTop(r: Float, g: Float, b: Float, a: Float){
        //top
        add(vertex: Vertex(x: 1, y: 1, z: 1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: 1, y: 1, z: -1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: -1, y: 1, z: -1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: 1, y: 1, z: 1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: -1, y: 1, z: -1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: -1, y: 1, z: 1, r: r, g: g, b: b, a: a))

    }
    private func createBottom(r: Float, g: Float, b: Float, a: Float){
    //bottom
        add(vertex: Vertex(x: 1, y: -1, z: 1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: -1, y: -1, z: -1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: 1, y: -1, z: -1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: 1, y: -1, z: 1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: -1, y: -1, z: 1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: -1, y: -1, z: -1, r: r, g: g, b: b, a: a))
    }
    private func createBack(r: Float, g: Float, b: Float, a: Float){
        //back
        add(vertex: Vertex(x: 1, y: 1, z: -1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: -1, y: -1, z: -1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: -1, y: 1, z: -1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: 1, y: 1, z: -1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: 1, y: -1, z: -1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: -1, y: -1, z: -1, r: r, g: g, b: b, a: a))
    }
    private func createFront(r: Float, g: Float, b: Float, a: Float){
    //front
        add(vertex: Vertex(x: -1, y: 1, z: 1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: -1, y: -1, z: 1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: 1, y: -1, z: 1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: 1, y: 1, z: 1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: -1, y: 1, z: 1, r: r, g: g, b: b, a: a))
        add(vertex: Vertex(x: 1, y: -1, z: 1, r: r, g: g, b: b, a: a))
    }
    public init(named: String, position: float3, left: Color, right: Color, top: Color, bottom: Color, back: Color, front: Color){
            self.name = named
            self.transforms.position = position
            createLeft(r: left.r, g: left.g, b: left.b, a: left.a)
            createRight(r: right.r, g: right.g, b: right.b, a: right.a)
            createTop(r: top.r, g: top.g, b: top.b, a: top.a)
            createBottom(r: bottom.r, g: bottom.g, b: bottom.b, a: bottom.a)
            createBack(r: back.r, g: back.g, b: back.b, a: back.a)
            createFront(r: front.r, g: front.g, b: front.b, a: front.a)
    }
}
