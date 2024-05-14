import simd

public class LightNode: GameNode{
	public var color: SIMD3<Float> = .one
	public var intensity: SIMD4<Float> = .one  
	
	public init(named name: String){
		super.init(named: name)
	}
	
	public var brightness: Float {
		get{	intensity.v0	}
		set {	intensity.v0 = newValue	}
	}
	public var ambienceIntensity: Float {
		get{	intensity.v1	}
		set {	intensity.v1 = newValue	}
	}
	public var diffuseIntensity: Float{
		get{	intensity.v2	}
		set {	intensity.v2 = newValue	}
	}
	public var specularIntensity: Float{
		get{	intensity.v3	}
		set {	intensity.v3 = newValue	}
	}
	
}
