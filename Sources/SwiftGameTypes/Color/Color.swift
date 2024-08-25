import simd
import Metal

public struct GameColor{
	public let r: Float
	public let g: Float
	public let b: Float
	public let a: Float
	
	public init(_ r: Float, _ g: Float, _ b: Float, _ a:Float){
		self.r = r
		self.g = g
		self.b = b
		self.a = a
	}
	
	public init(_ r: Float, _ g: Float, _ b: Float){
		self.r = r
		self.g = g
		self.b = b
		self.a = 1
	}

	public var rgba: SIMD4<Float> {
		SIMD4<Float>(r, g, b, a)
	}
	public var rgb: SIMD3<Float>{
		SIMD3<Float>(r, g, b)
	}
	
	public var clearColor: MTLClearColor{
		MTLClearColorMake(Double(r), Double(g), Double(b), Double(a))
	}
	

}


extension GameColor: CustomStringConvertible{
	public var description: String {
		"R" + r.description + "_G" + g.description + "_B" + b.description + "_A" + a.description
	} 
}
extension GameColor{
	static public var random: GameColor{
		let r: Float = .random(in: 0...1)
		let g: Float = .random(in: 0...1)
		let b: Float = .random(in: 0...1)
		return GameColor(r,g,b,1)
	}
	
}
