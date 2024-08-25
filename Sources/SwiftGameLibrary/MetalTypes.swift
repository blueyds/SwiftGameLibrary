import simd
import SwiftGameTypes

public struct SceneConstants: sizeable{
	public let viewMatrix: Matrix
	public let projectionMatrix: Matrix
	public let cameraPos: SIMD3<Float>
	public let light: LightData
}

public struct LightData: sizeable {
	public let position: SIMD3<Float>
	public let color: SIMD3<Float>
	public let brightness: Float
	public let ambienceIntensity: Float
	public let diffuseIntensity: Float
	public let specularIntensity: Float
	public static var noLight: LightData {
		LightData(position: .zero, color: .zero, brightness: 0, ambienceIntensity: 0, diffuseIntensity: 0, specularIntensity: 0)
	}
}
public struct MaterialData: sizeable {
	public let color: SIMD4<Float>
	public let isLit: Bool
	public let ambience: SIMD3<Float>
    public let diffuse: SIMD3<Float>
    public let specular: SIMD3<Float>
    public let shininess: Float
}
public struct ModelConstants: sizeable {
	public let modelMatrix: Matrix
	public let normalMatrix: simd_float3x3
	public let material: MaterialData
}
