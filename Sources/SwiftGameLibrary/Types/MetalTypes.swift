import simd

public struct SceneConstants: sizeable{
	public let viewMatrix: Matrix
	public let projectionMatrix: Matrix
	public let cameraPos: SIMD3<Float>
	public let lightCount: Int
	public let lights: [LightData]
	public var stride: Int{
		Matrix.stride(of: 2) + SIMD3<Float>.stride() + Int.stride() + LightData.stride(of: lightCount)
	}
}

public struct LightData: sizeable {
	public let position: SIMD3<Float>
	public let color: SIMD3<Float>
	public let brightness: Float
	public let ambienceIntensity: Float
	public let diffuseIntensity: Float
	public let specularIntensity: Float
}
public struct MaterialData: sizeable {
	public let color: SIMD4<Float>
	public let isLit: Bool
	public let ambient: SIMD3<Float>
	public let diffuse: SIMD3<Float>
	public let specular: SIMD3<Float>
	public let shininess: Float
	
}
public struct ModelConstants: sizeable {
	public let modelMatrix: Matrix
	
	public let material: MaterialData
}
