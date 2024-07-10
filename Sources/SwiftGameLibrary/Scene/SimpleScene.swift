//
//  File.swift
//  
//
//  Created by Craig Nunemaker on 7/4/24.
//

import Foundation
public class SimpleScene: GameScene{
    public let id: Int = Int.NextID()
    public var name: String
    public var children: [any GameNode] = []
    public var actions: [any Action] = []
	public var lights: [LightNode] = []
	public var camera: CameraNode!
    
    public init(named name: String, using engine: MainEngine){
        self.name = name
        buildMeshes(engine: engine)
        buildScene(engine: engine)
    }
    
	public func buildMeshes(engine: MainEngine) { }

	public func buildScene(engine: MainEngine) { }

	public func doUpdate(counter ticks: TickCounter) { }

	public func getCamera() -> CameraNode {
		camera
	}

}
