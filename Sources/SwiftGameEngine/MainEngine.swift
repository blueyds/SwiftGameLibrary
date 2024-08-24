import Foundation
import Metal

public class MainEngine{
	// public static var shared: MainEngine = MainEngine()
	public var device: MTLDevice?
	public var library: MTLLibrary?
	public var commandQueue: MTLCommandQueue?
	public var pixelFormat: MTLPixelFormat
	public var depthFormat: MTLPixelFormat
	public var stencilFormat: MTLPixelFormat
	public init(pixelFormat: MTLPixelFormat, depthFormat: MTLPixelFormat, stencilFormat: MTLPixelFormat){
		device = MTLCreateSystemDefaultDevice()
		commandQueue = device?.makeCommandQueue()
		if device == nil {
			fatalError("device failed to init")
		}
		if commandQueue == nil {
			fatalError("commandQueue failed ot init")
		}
		self.pixelFormat = pixelFormat
		self.depthFormat = depthFormat
		self.stencilFormat = stencilFormat
	}
	public func setupLibrary(withSource: String){
		library = try? device?.makeLibrary(source: withSource, options: nil)
		if library == nil {
			fatalError("library failed to init")
		}
	}
	
	public func setupLibrary(){ 
		library = device?.makeDefaultLibrary()
		if library == nil {
			fatalError("library failed to init")
		}
	}
	
	public func makePipelineState( vertexFunction: String, fragmentFunction: String) -> MTLRenderPipelineState?{
		let pipelineDescriptor = MTLRenderPipelineDescriptor()
		pipelineDescriptor.colorAttachments[0].pixelFormat = pixelFormat
		pipelineDescriptor.depthAttachmentPixelFormat = depthFormat
		pipelineDescriptor.stencilAttachmentPixelFormat = stencilFormat
		pipelineDescriptor.vertexFunction = library!.makeFunction(name: vertexFunction)
		pipelineDescriptor.fragmentFunction = library!.makeFunction(name: fragmentFunction)
		pipelineDescriptor.vertexDescriptor = Vertex.vertexDescriptor
		return try? device!.makeRenderPipelineState(descriptor: pipelineDescriptor)
	}
	public func makeDepthState( isDepthWriteEnabled: Bool, depthCompareFunction: MTLCompareFunction) -> MTLDepthStencilState? {
		let depthStencilDescriptor = MTLDepthStencilDescriptor()
		depthStencilDescriptor.isDepthWriteEnabled = isDepthWriteEnabled
		depthStencilDescriptor.depthCompareFunction = depthCompareFunction
		return device?.makeDepthStencilState(descriptor: depthStencilDescriptor)
	}
	
}
