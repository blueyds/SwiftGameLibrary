import simd
import Metal

public struct Color: Nameable{
    public let name: String
    public let r: Float
    public let g: Float
    public let b: Float
    public let a: Float
    
    init(_ r: Float, _ g: Float, _ b: Float, _ a:Float, named: String){
        self.r = r
        self.g = g
        self.b = b
        self.a = a
        self.name = named
    }
    public var vector: float4 {
        float4(r, g, b, a)
    }
    public var clearColor: MTLClearColor{
        MTLClearColorMake(Double(r), Double(g), Double(b), Double(a))
    }
    static public func black(a: Float = 1)-> Color{ Color(0,0,0,a,named: "black")}
    static public func navy(a: Float = 1)-> Color { Color(0,0,0.5,a, named: "navy")}
    static public func blue(a: Float = 1)-> Color { Color(0,0,1,a, named: "blue")}
    static public func green(a: Float = 1)-> Color { Color(0, 0.5, 0, a, named: "green")}
    static public func teal(a: Float = 1)-> Color { Color(0, 0.5, 0.5, a, named: "teal")}
    static public func lime(a: Float = 1)-> Color { Color(0, 1, 0, a, named: "lime")}
    static public func aqua(a: Float = 1 ) -> Color { Color(0, 1, 1, a, named: "aqua")}
    static public func maroon(a: Float = 1) -> Color { Color(0.5, 0, 0, a, named: "maroon")}
    static public func purple(a: Float = 1) -> Color { Color(0.5, 0, 0.5, a, named: "purple")}
    static public func olive(a: Float = 1) -> Color { Color(0.5, 0.5, 0, a, named: "olive")}
    static public func gray(a: Float = 1) -> Color { Color(0.5, 0.5, 0.5, a, named: "gray")}
    static public func silver(a: Float = 1) -> Color { Color(0.75, 0.75, 0.75, a, named: "silver")}
    static public func red(a: Float = 1) -> Color { Color(1, 0, 0, a, named: "red")}
    static public func fuchsia(a: Float = 1) -> Color { Color(1, 0, 1, a, named: "fuschia")}
    static public func yellow(a: Float = 1) -> Color { Color(1, 1, 0, a, named: "yellow")}
    static public func white(a: Float = 1) -> Color { Color(1, 1, 1, a, named: "white")}
    
    static public func randomColor()->SwiftGameLibrary.Color{
        let a: Float = Float.random(in: 0...1)
        let i = Int.random(in: 1...16)
        switch i {
        case 1: return Color.black(a: a)
        case 2: return Color.navy(a: a)
        case 3: return Color.blue(a: a)
        case 4: return Color.green(a: a)
        case 5: return Color.teal(a: a)
        case 6: return Color.lime(a: a)
        case 7: return Color.aqua(a: a)
        case 8: return Color.maroon(a: a)
        case 9: return Color.purple(a: a)
        case 10: return Color.olive(a: a)
        case 11: return Color.gray(a: a)
        case 12: return Color.silver(a: a)
        case 13: return Color.red(a: a)
        case 14: return Color.fuchsia(a: a)
        case 15: return Color.yellow(a: a)
        case 16: return Color.white(a: a)
        default: return Color.black(a: a)
        }
    }
}

extension Color: CustomStringConvertible{
    public var description: String {
        "R" + r.description + "_G" + g.description + "_B" + b.description + "_A" + a.description"
    } 
}
