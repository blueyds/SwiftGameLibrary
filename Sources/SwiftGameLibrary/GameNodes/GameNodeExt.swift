//
//  File.swift
//  
//
//  Created by Craig Nunemaker on 6/24/24.
//

import Foundation
import simd

extension GameNode {
	public func PositionAt(x: Float, y: Float, z: Float)->GameNode{
		let result = self
		result.position = SIMD3(x, y, z)
		return result
	}

	public func ScaleBy(x: Float, y: Float, z: Float)->GameNode{
		let result = self
		result.scale = SIMD3(x, y, z)
		return result
	}

	public func ScaleBy(all: Float)->GameNode{
		ScaleBy(x: all, y: all, z: all)
	}

}
