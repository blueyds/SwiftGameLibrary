
import simd
import Metal

open class BasicScene: GameScene{
    public var name: String
    public var id: Int = Int.NextID()
    public var children: [any GameNode] = []
    public var camera: Camera = PerspectiveCamera(named: "Perspective Camera")
    
    public init(named: String, using engine: MainEngine){
        self.name = named
        buildCamera(using: engine)
    
        buildScene(using: engine)
    }
    
    open func buildScene(using: MainEngine){}
    
    open func buildCamera(using: MainEngine) {}
    
    
}
