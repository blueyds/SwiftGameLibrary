//
//  File.swift
//  
//
//  Created by Craig Nunemaker on 7/4/24.
//

import Foundation
public class SimpleScene: GameScene{
    let id: Int = Int.NextId()
    var name: String
    var children: [any GameNode] = []
    var actions: [any Action] = []
	var lights: [LightNode] = []
	var camera: CameraNode!
    
    public init(named name: String, using engine: MainEngine){
        self.name = name
        buildMeshes(engine: engine)
        buildScene(engine: engine)
    }
    
	public func buildMeshes(engine: MainEngine) { }

	public func buildScene(engine: MainEngine) { }

	public func doUpdate(counter ticks: TickCounter) { }

	public func getLightNodes()->[LightNode] { [] }

	public func getCamera() -> CameraNode {
		camera
	}

	public func getLightNodes() -> [LightNode] {
		lights
	}
}
