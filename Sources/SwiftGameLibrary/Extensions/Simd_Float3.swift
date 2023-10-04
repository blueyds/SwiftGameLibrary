//
//  File.swift
//  
//
//  Created by Craig Nunemaker on 9/30/23.
//

import simd

public typealias float3 = simd_float3

extension float3{
	public static var Zero: float3 { simd_float3(repeating: 0)}
	public static var One: float3 { simd_float3(repeating: 1)}
}
