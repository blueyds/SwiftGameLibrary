import simd
import SwiftGameTypes

public class LightNode: GameNode{
	public let id: Int = Int.NextID()

	public var transforms: Transformable = Transformable()

	public var children: [any GameNode] = []

	//public var actions: [Action] = []

	public var color: SIMD3<Float> = .one
	var intensity: SIMD4<Float> = .one  
	
	// public init(named name: String){
	// 	super.init(named: name)
	// }
	
	public init(color: Color, ambienceIntensity: Float, diffuseIntensity: Float, specularIntensity: Float, brightness: Float, named name: String? = nil){
		self.color = color.rgb
		self.intensity = .zero
		self.brightness = brightness
		self.ambienceIntensity = ambienceIntensity
		self.diffuseIntensity = diffuseIntensity
		self.specularIntensity = specularIntensity
	}
	
	public var brightness: Float {
		get{	intensity.x	}
		set{	intensity.x = newValue	}
	}
	public var ambienceIntensity: Float {
		get{	intensity.y	}
		set{	intensity.y = newValue	}
	}
	public var diffuseIntensity: Float{
		get{	intensity.z	}
		set{	intensity.z = newValue	}
	}
	public var specularIntensity: Float{
		get{	intensity.w	}
		set{	intensity.w = newValue	}
	}
	
}
