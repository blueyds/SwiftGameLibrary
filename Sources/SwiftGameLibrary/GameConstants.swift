public struct VertexParameters{
	public static let Vertex = 0
	// general matrices
	public static let ModelMatrix = 1 
	public static let ViewMatrix = 2
	public static let ProjectionMatrix = 3
	
	// cameraData
	public static let CameraPosition = 50
	// node Data
	public static let WorldPosition = 100
	
}

public struct FragmentParameters{
	// light Data for fragment shader
	public static let LightCount = 10
	public static let LightPosition = 11
	public static let LightColor = 12
	public static let LightIntensity = 13
	//material data
	public static let Color = 101
	public static let IsLit = 102
	public static let Ambient = 103
	public static let Diffuse = 104
	public static let Specular = 105
	public static let Shininess = 106
}