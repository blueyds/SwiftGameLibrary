import Foundation
import simd

public struct AxisAlignedBoundingBox{
	var min: SIMD3<Float>
	var max: SIMD3<Float>
	public init(worldPos: SIMD3<Float>, lengthOnXAxis: Float, lengthOnYAxis: Float, lengthOnZAxis: Float){
		let extants = SIMD3(lengthOnXAxis / 2, lengthOnYAxis / 2, lengthOnZAxis / 2)
		let center = worldPos
		min = simd_float3(center.x - extants.x, center.y - extants.y, center.z - extants.z)
		max = simd_float3(center.x + extants.x, center.y + extants.y, center.z + extants.z)
	}
	
	private func tMinMax(boxMin: Float, boxMax: Float, origin: Float, invertedDirection: Float)->(min: Float, max: Float){
		var result: (min: Float, max: Float) 
		if (invertedDirection >= 0) { 
			result = (
				min: (boxMin - origin) * invertedDirection,
				max: (boxMax - origin) * invertedDirection)
		}
		else { 
			result = (
				min: (boxMax - origin) * invertedDirection,
				max: (boxMin - origin) * invertedDirection
			)
		}
		// swap if min is greater than max
		if result.min > result.max {
			let temp = result
			result = (min: temp.max, max: temp.min)
		}
		return result
	}

	public func intersect(_ ray: Ray) -> Float?{
		let tx = tMinMax(boxMin: min.x, boxMax: max.x, origin: ray.origin.x, invertedDirection: ray.invertedDirection.x)
		let ty = tMinMax(boxMin: min.y, boxMax: max.y, origin: ray.origin.y, invertedDirection: ray.invertedDirection.y)
		let tz = tMinMax(boxMin: min.z, boxMax: max.z, origin: ray.origin.z, invertedDirection: ray.invertedDirection.z)
		if tx.min > ty.max { return nil }
		if tx.min > tz.max { return nil }

		let tmin = SIMD3(tx.min, ty.min, tz.min).min()
		let tmax = SIMD3(tx.max, ty.max, tz.max).max()
		if tmin < 0 { 
			return tmax
		} else {
			return tmin
		}
	}
}