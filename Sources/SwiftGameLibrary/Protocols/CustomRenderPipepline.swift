import Metal

public protocol CustomRenderPipeline{
    var renderPipeline: MTLRenderPipeline { get set }
}

extension CustomRenderPipeline {
    public func assignPipeline(to encoder: MTLRenderPipelineEncoder){
        encoder.setRenderPipelineState(renderPipeline)
    }
}