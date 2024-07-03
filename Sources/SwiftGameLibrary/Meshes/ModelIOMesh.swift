import ModelIO
import MetalKit
import Metal

public protocol ModelIOMesh: Mesh{
	var mesh: MTKMesh? { get set }
}

extension ModelIOMesh{
	public func load(mdlMesh model: MDLMesh, using device: any MTLDevice){
		do {
			mesh = try MTKMesh(mesh: model, device: device)
			} catch{
				mesh = nil
				Log.error("Could not load mdlMesh")
			}
	}
	
	public func drawPrimitives(using renderCommandEncoder: MTLRenderCommandEncoder){
		if mesh == nil {
			return
		}
		var index = 0
		for submesh in mesh!.submeshes {
			// submesh is a MTKSubmesh, containing an MTKMeshBuffer
			// set the vertex buffer for this submesh
			if let vertexBuffer = mesh?.vertexBuffers[index]{
				renderCommandEncoder.setVertexBuffer(
					vertexBuffer.buffer,
					offset: vertexBuffer.offset, 
					index: 0)
			}
				renderCommandEncoder.drawIndexedPrimitives(
					type: submesh.primitiveType, 
					indexCount: submesh.indexCount, 
					indexType: submesh.indexType, 
					indexBuffer: submesh.indexBuffer.buffer, 
					indexBufferOffset: submesh.indexBuffer.offset)
			index += 1
		}
	}
}
// then, at render time...
