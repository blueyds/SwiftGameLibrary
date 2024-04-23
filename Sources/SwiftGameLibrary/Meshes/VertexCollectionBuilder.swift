/* import simd

struct VertexCollectionBuilder{
    private var inVertices: [Vertex] = []
    private var processedVertices: [Vertex] = []
	private var processedIndices: [UInt16] = []
    private var triangles: [Triangle]
    public init(){
        triangles = []
        triangles.append(Triangle())
    
	}
	
    mutating public func getProcessedVertexData()->[Vertex]{
        if processedVertices.count == inVertices.count{
            return processedVertices
        }
        processVertices()
        return processedVertices
    }
	mutating public func getIndexedVertexData()->([Vertex],[UInt16]){
		if processedVertices.count == inVertices.count{
            return processedVertices
        }
        processVertices()
		processIndices()
		
	}
	mutating public func add(_ x: Float, _ y: Float, _ z: Float, _ color: Color){
        let v = Vertex(SIMD3<Float>(x,y,z), color)
        add(v)
    }
    mutating public func add(_ vertex: Vertex){
        inVertices.append(vertex)
        var t = triangles.popLast()!
        if t.isFull(){
            triangles.append(t)
            var t1 = Triangle()
            t1.add(vertex.position)
            triangles.append(t1)
        } else {
            t.add(vertex.position)
            triangles.append(t)
        }
    }
    
    mutating private func processVertices(){
        processedVertices = []
        
        var vectorNormals: [SIMD3<Float>:SIMD3<Float>] = [:]
        inVertices.forEach(){
            var v = $0
            if let norm = vectorNormals[v.position] {
                v.normals = norm
            } else {
                let normal = calculateNormal(v.position)
                vectorNormals.updateValue(normal, forKey: v.position)
                v.normals = normal
            }
            processedVertices.append(v)
        }
        
        if processedVertices.count != inVertices.count {
            fatalError("process vertices does not equal inVertices")
        }
        
    }
	// TODO: implement indexed primitives
	mutating private func processIndices(){
		inVertices = processedVertices
		processedIndices = []
	}
    private func calculateNormal(_ v: SIMD3<Float>)->SIMD3<Float>{
        var normals: [SIMD3<Float>] = []
//    var count = 1
        triangles.forEach(){ triangle in
            if triangle.contains(v){
                normals.append(triangle.normal)
            }
        }
        return normals.average()
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
} */