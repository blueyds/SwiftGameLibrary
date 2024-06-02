import simd

public class LightNode: GameNode{
	public var color: SIMD3<Float> = .one
	public var intensity: SIMD4<Float> = .one  
	
	// public init(named name: String){
	// 	super.init(named: name)
	// }
	
	public init(color: Color, ambienceIntensity: Float, diffuseIntensity: Float, specularIntensity: Float, brightness: Float){
		self.color = color.rgb
		self.intensity = SIMD4<Float>(brightness, ambienceIntensity, diffuseIntensity, specularIntensity)
		super.init()
	}
	public var brightness: Float {
		get{	intensity.x	}
		set {	intensity.x = newValue	}
	}
	public var ambienceIntensity: Float {
		get{	intensity.y	}
		set {	intensity.y = newValue	}
	}
	public var diffuseIntensity: Float{
		get{	intensity.z	}
		set {	intensity.z = newValue	}
	}
	public var specularIntensity: Float{
		get{	intensity.w	}
		set {	intensity.w = newValue	}
	}
	
}
