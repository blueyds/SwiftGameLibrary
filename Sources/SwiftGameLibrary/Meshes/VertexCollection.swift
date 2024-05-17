import Metal
import simd
public protocol VertexCollection: Mesh{
	var vertices: [Vertex] { get set}
	var vertexBuffer: MTLBuffer? { get set }
	func createVertices() 
}
extension VertexCollection{
	public func  build(){
		createVertices()
		vertexBuffer = nil
		processVertices()
	}
	public func build(using device: MTLDevice){
		createVertices()
		createBuffer(using: device)
	}
	
	public func createBuffer(using device: MTLDevice){
		if  vertices.count >  0{
			vertexBuffer = device.makeBuffer(bytes: vertices, length: Vertex.stride(of: vertices.count), options: [])
		}
	}
	public func setVertices(to encoder: MTLRenderCommandEncoder){
		if vertexBuffer == nil {
			encoder.setVertexBytes(vertices, length: Vertex.stride(of: vertices.count), index: VertexParameters.Vertex)
		} else {
			encoder.setVertexBuffer(vertexBuffer, offset: 0, index: VertexParameters.Vertex)
		}
	}
	public func drawPrimitives(using encoder: MTLRenderCommandEncoder){
        encoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
    }

	public func add(vertex: Vertex){
		vertices.append(vertex)
	}
	
	public func add(_ x: Float, _ y: Float, _ z: Float, _ r: Float, _ g: Float, _ b: Float, _ a: Float){
		let v = Vertex(SIMD3<Float>(x,y,z), Color(r,g,b,a))
		add(vertex: v)    
	}
	public func add(_ x: Float,_ y: Float,_ z: Float, _ color: Color){
		let v = Vertex(SIMD3<Float>(x,y,z), color)
		add(vertex: v)
	}
	
	func processVertices(){
		var inVertices: [Vertex] = []
    	var processedVertices: [Vertex] = []
		var triangles: [Triangle] = [Triangle()]
		// add each vertex to the process queue
    	vertices.forEach(){vIn in 
			inVertices.append(vIn)
        	var t = triangles.popLast()!
        	if t.isFull(){
            	triangles.append(t)
            	var t1 = Triangle()
            	t1.add(vIn.position)
            	triangles.append(t1)
        	} else {
            	t.add(vIn.position)
            	triangles.append(t)
        	}
		}
        var vectorNormals: [SIMD3<Float>:SIMD3<Float>] = [:]
        inVertices.forEach(){
            var v = $0
            if let norm = vectorNormals[v.position] {
                v.normals = norm
            } else { // we need to calculate the normal for that pos
				var normals: [SIMD3<Float>] = []
        		triangles.forEach(){ triangle in
            	if triangle.contains(v){
                	normals.append(triangle.normal)
            	}	
        	    vectorNormals.updateValue(normal.average, forKey: v.position)
                v.normals = normal
            }
            processedVertices.append(v)
        }
        
        if processedVertices.count != inVertices.count {
            fatalError("process vertices does not equal inVertices")
        }
        vertices = processedVertices
    }
	
    struct Triangle{
        var v1: SIMD3<Float>? = nil
        var v2: SIMD3<Float>? = nil
        var v3: SIMD3<Float>? = nil
        var n: SIMD3<Float>? = nil
        var normal: SIMD3<Float> { 
            if checkNormal() { return n!}
            else { fatalError("CheckNormal failed")}
        }
        private func checkNormal()->Bool{
            n != nil && v1 != nil && v2 != nil && v3 != nil
        }
        mutating func add(_ vertex: SIMD3<Float>){
            if v1 == nil { 
                v1 = vertex
            }else if v2 == nil { 
                v2 = vertex
            } else{
                v3 = vertex
                calculateNormal()    
            }
        }
        public func isFull()->Bool { v3 != nil }
        
        func contains(_ vector: SIMD3<Float>)->Bool{
            if v1 == vector { return true }
            if v2 == vector { return true }
            if v3 == vector { return true }
            return false
        }
        
        var description: String {
            "v1\(v1 ?? .zero) v2\(v2 ?? .zero) v3\(v3 ?? .zero) normal \(n ?? .zero)"
        }
        
        mutating private func calculateNormal(){
            if v1 == nil || v2 == nil || v3 == nil {
                fatalError("Not enough vectors to caldulation")
            }
            let vector1 =  v1! - v2!
            let vector2 = v1! - v3!
            n = simd_normalize(simd_cross(vector1, vector2))
        }
        
    }
}