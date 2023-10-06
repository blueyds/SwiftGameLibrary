
import simd
import Metal

open class BasicScene: GameScene{
    public var name: String
    public var children: [any GameNode] = []
    public var pipelines: [MTLRenderPipelineState] = []
    public var transforms = Transforms()
    public var camera: Camera
    
    public init(named: String, using engine: MainEngine){
        self.name = named
        buildPipelines(using: engine)
        buildScene(using: engine)
        buildCamera(using: engine)
    }
    
    open func buildPipelines(using: MainEngine){}
    
    open func buildScene(using: MainEngine){}
    
    open func buildCamera(using: MainEngine) {}
    
    
}
