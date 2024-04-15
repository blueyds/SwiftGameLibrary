/*import simd

struct VertexCollectionBuilder{
	private var inVertices: [Vertex] = []
	private var processedVertices: [Vertex] = []
	private var triangles: [Triangle] = []
	init(){
		
	}
	
	mutating public func getProcessedVertexData()->[Vertex]{
		if processedVertices.count == inVertices.count{
			return processedVertices
		}
		process()
		return processedVertices
	}
	mutating public func add(_ x: Float, _ y: Float, _ z: Float, _ color: Color){
		let v = Vertex(float3(x,y,z), color)
		add(v)
	}
	mutating public func add(_ vertex: Vertex){
		inVertices.append(vertex)
		if triangles.count == 0 {
			triangles.append(Triangle())
		}
		let index = triangles.count - 1
		if !triangles[index].add(vertex.position){
			triangles.append(Triangle())
			triangles[index + 1].add(vertex.position)
		}
	}
	
	mutating private func process(){
		processedVertices = []
		inVertices.forEach(){
			var v = $0
			var normals: [float3] = []
			triangles.forEach(){ triangle in
				if triangle.contains(v.position){
					normals.append(triangle.normal)
				}
			}
			v.normals = simd_normalize(normals.average())
			processedVertices.append(v)
		}
		if processedVertices.count != inVertices.count {
			fatalError("process vertices does not equal inVertices")
		}
	}
	
	
	struct Triangle{
		private var v: [float3] = []
		//private var c: [float4] = []
		private var n: float3? = nil
		private var vertices:[float3]{ v }
		//var colors: [float4] { c }
		
		var normal: float3 { 
			if checkNormal() { return n!}
			else { fatalError("CheckNormal failed \(description)")}
		}
		private func checkNormal()->Bool{
			n != nil && v.count == 3
		}
		mutating func add(_ vertex: float3)-> Bool{
			if v.count > 2 { 
				calculateNormal()
				return false
			}
			v.append(vertex)
			//c.append(color)
			return true
		}
		
		func contains(_ vector: float3)->Bool{
			v.contains(vector)
		}
		
		var description: String {
			"v1:\(v[0]) v2:\(v[1]) v3:\(v[2]) n:\(normal)"
		}
		
		mutating private func calculateNormal(){
			if v.count != 3 {
				fatalError("trying to calculate normal with less than three vectors \(description)")
			}
			let v1 = v[1] - v[2]
			let v2 = v[1] - v[0]
			n = simd_normalize(simd_cross(v1,v2))
		}
		
	}
}
/*
normal for a vector is the cross productof adjacent triangle normals
i
calculatr normal of trianle
The following code defines the three vertices of the triangle:
let vertex1 = simd_float3(-1.5, 0.5, 0)
let vertex2 = simd_float3(1, 0, 3)
let vertex3 = simd_float3(0.5, -0.5, -1.5)
Your first step in calculating the normal of the triangle is to create two vectors defined by the difference between the vertices—representing two sides of the triangle:
let vector1 = vertex2 - vertex3
let vector2 = vertex2 - vertex1
The simd_cross function returns the vector that's perpendicular to the two vectors you pass it. In this example, the returned vector is the normal of the triangle. Because the normal represents a direction, you can normalize the value to get a unit vector:
let normal = simd_normalize(simd_cross(vector1, vector2)) 
*/
*/