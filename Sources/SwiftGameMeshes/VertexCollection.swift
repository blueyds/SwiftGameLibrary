import Metal
import simd
import SwiftGameTypes


/// VertexCollection is a protocol tha can be used by a custom mesh that allows the class to manually
/// create vertices. There are procedures for addeing vertex. Implementations only need to
/// define vertices and the vertexBuffer, and implement the createVertices func.
/// Implementations should call one of the build funcs in their initilizer. The build funcs call the createVertices
/// func and call other procedures to ensure
public protocol VertexCollection: Mesh{
	var vertices: [Vertex] { get set}
	var vertexBuffer: MTLBuffer? { get set }
	func createVertices() 
    /// Implement this or even do an extension to provede the index into tthe Metal Shder language for the vertex
  
}

extension VertexCollection{
    
	/// Can be called in the initializer of classes to simplify the build process and ensure that normals
	///  are created
	public func  build(){
		createVertices()
		vertexBuffer = nil
		processVertices()
	}
	
	/// Can be called in the initializer of classes to simplify the build process and ensure that normals
	/// are created
	public func build(using device: MTLDevice){
		createVertices()
		processVertices()
		createBuffer(using: device)
	}
	
	public func createBuffer(using device: MTLDevice){
		if  vertices.count >  0{
			vertexBuffer = device.makeBuffer(bytes: vertices, length: Vertex.stride(of: vertices.count), options: [])
		}
	}
	
	public func setVertices(to encoder: MTLRenderCommandEncoder){
		if vertexBuffer == nil {
			encoder.setVertexBytes(&vertices, length: Vertex.stride(of: vertices.count), index: 0)
		} else {
			encoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0 )
		}
	}
	
	public func drawPrimitives(using encoder: MTLRenderCommandEncoder){
		encoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
	}

	public func add(vertex: Vertex){
		vertices.append(vertex)
	}
	
	public func add(_ x: Float, _ y: Float, _ z: Float, _ r: Float, _ g: Float, _ b: Float, _ a: Float){
		let v = Vertex(x, y, z, r, g, b, a)
		add(vertex: v)    
	}
	
	public func add(_ x: Float, _ y: Float, _ z: Float, _ r: Float, _ g: Float, _ b: Float, _ a: Float, _ u: Float, _ v: Float){
		let v = Vertex(x, y, z, r, g, b, a, u, v)
		add(vertex: v)    
	}
	
	public func add (_ x: Float, _ y: Float, _ z: Float, _ color: GameColor, _ u: Float, _ v: Float){
		let v = Vertex(x, y, z, color.r, color.g, color.b, color.a, u, v)
		add(vertex: v)
	}
	
	public func add(_ x: Float,_ y: Float,_ z: Float, _ color: GameColor){
		let v = Vertex(x, y, z, color.r, color.g, color.b, color.a, 0, 0)
		add(vertex: v)
	}
	
	func processVertices(){
		var processedVertices: [Vertex] = []
		var triangles: [Triangle] = [Triangle()]
		// add each vertex to a triangle structure array
		vertices.forEach(){vIn in 
			var t = triangles.popLast()!
			if t.isFull(){
				// prior triangle is full. crealte a new one and add it
				triangles.append(t)
				var t1 = Triangle()
				t1.add(vIn.position)
				triangles.append(t1)
			} else {
				// just append to a triangle
				t.add(vIn.position)
				triangles.append(t)
			}
		}
		var vectorNormals: [SIMD3<Float>:SIMD3<Float>] = [:]
		vertices.forEach(){
			var v = $0
			if let norm = vectorNormals[v.position] {
				v.normals = norm
			} else { // we need to calculate the average normal for that pos
				var normals: [SIMD3<Float>] = []
				triangles.forEach() { triangle in
					if triangle.contains(v.position){
						normals.append(triangle.normal)
					}
				}
				v.normals = normals.average()
				vectorNormals.updateValue(v.normals, forKey: v.position)
			}
			processedVertices.append(v)
		}
		if processedVertices.count != vertices.count {
			fatalError("process vertices does not equal inVertices")
		}
		vertices = processedVertices
	}
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
	
	mutating private func calculateNormal(){
 		if v1 == nil || v2 == nil || v3 == nil {
			fatalError("Not enough vectors to caldulation")
		}
		let vector1 =  v1! - v2!
		let vector2 = v1! - v3!
		n = simd_normalize(simd_cross(vector1, vector2))
	}
}
