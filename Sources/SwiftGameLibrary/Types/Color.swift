import simd
import Metal

public struct Color: Nameable{
	public let name: String
	public let r: Float
	public let g: Float
	public let b: Float
	public let a: Float
	
	public init(_ r: Float, _ g: Float, _ b: Float, _ a:Float, named: String){
		self.r = r
		self.g = g
		self.b = b
		self.a = a
		self.name = named
	}
	public init(_ r: Float, _ g: Float, _ b: Float,_ a: Float){
		self.r = r
		self.g = g
		self.b = b
		self.a = a
		self.name = "R\(r)_G\(g)_B\(b)_A\(a)"
	}
	
	public init(_ r: Float, _ g: Float, _ b:Float){
		self.r = r
		self.g = g
		self.b = b
		self.a. = 1
		self.name = "R\(r)_G\(g)_B\(b)_A\(a)"
	}
	
	public var vector: SIMD4<Float> {
		SIMD4<Float>(r, g, b, a)
	}
	
	public var clearColor: MTLClearColor{
		MTLClearColorMake(Double(r), Double(g), Double(b), Double(a))
	}
	

}


extension Color: CustomStringConvertible{
	public var description: String {
		"R" + r.description + "_G" + g.description + "_B" + b.description + "_A" + a.description
	} 
}
extension Color{
	static public var random: Color{
		let r: Float = .random(in: 0...1)
		let g: Float = .random(in: 0...1)
		let b: Float = .random(in: 0...1)
		return Color(r,g,b,1)
	}
	static public var black: Color{ Color(0,0,0,named: "black")}
	static public var navy: Color { Color(0,0,0.5, named: "navy")}
	static public var blue: Color { Color(0,0,1, named: "blue")}
	static public var green: Color { Color(0, 0.5, 0, named: "green")}
	static public var teal: Color { Color(0, 0.5, 0.5, named: "teal")}
	static public var lime: Color { Color(0, 1, 0, named: "lime")}
	static public var aqua: Color { Color(0, 1, 1, named: "aqua")}
	static public var maroon: Color { Color(0.5, 0, 0, named: "maroon")}
	static public var purple: Color { Color(0.5, 0, 0.5, named: "purple")}
	static public var olive: Color { Color(0.5, 0.5, 0, named: "olive")}
	static public var gray: Color { Color(0.5, 0.5, 0.5, named: "gray")}
	static public var silver: Color { Color(0.75, 0.75, 0.75, named: "silver")}
	static public var red: Color { Color(1, 0, 0, named: "red")}
	static public var fuchsia: Color { Color(1, 0, 1, named: "fuschia")}
	static public var yellow: Color { Color(1, 1, 0, named: "yellow")}
	static public var white: Color { Color(1, 1, 1, named: "white")}
}
