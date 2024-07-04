//
//  File.swift
//  
//
//  Created by Craig Nunemaker on 7/4/24.
//

import Foundation
public protocol SimpleScene: GameScene{

	var lights: [LightNode] { get set }

	var camera: CameraNode! { get set}
}

extension SimpleScene{
	public func buildAll(using engine: MainEngine){
		buildMeshes(engine: engine)
		buildScene(engine: engine)
		camera = findCamera()
		lights = findAllLights()
	}

	public func getCamera() -> CameraNode {
		camera
	}

	public func getLightNodes() -> [LightNode] {
		lights
	}
}
