import Metal

public protocol CustomRenderPipeline{
    var renderPipeline: MTLRenderPipelineState { get set }
}

extension CustomRenderPipeline {
    public func assignPipeline(to encoder: MTLRenderCommandEncoder){
        encoder.setRenderPipelineState(renderPipeline)
    }
}