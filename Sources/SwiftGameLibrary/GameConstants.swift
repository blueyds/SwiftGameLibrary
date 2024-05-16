public struct VertexParameters{
	public static let Vertex = 0
	// general matrices
	public static let ModelMatrix = 1 
	public static let ViewMatrix = 2
	public static let ProjectionMatrix = 3
	
	// cameraData
	public static let CameraPosition = 4
	// node Data
	
}

public struct FragmentParameters{
	// light Data for fragment shader
	public static let LightCount = 1
	public static let LightPosition = 2
	public static let LightColor = 3
	public static let LightIntensity = 4
	//material data
	public static let Color = 5
	public static let IsLit = 6
	public static let Ambient = 7
	public static let Diffuse = 8
	public static let Specular = 9
	public static let Shininess = 10
}