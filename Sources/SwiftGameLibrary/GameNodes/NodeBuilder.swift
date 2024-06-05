
@resultBuilder
public enum GameNodesBuilder{
	public static func buildBlock(_ components: GameNode...)->[GameNode] {
		components
	}
}

public func AssembleNode(_ ownerNode: GameNode, @GameNodesBuilder _ builder: () -> [GameNode]){
	builder().forEach{
		ownerNode.add(child: $0)
	}
}

public func AssembleScene(_ scene: GameScene, @GameNodesBuilder _ builder: () -> [GameNode]){
	builder().forEach{
		scene.add(child: $0)
	}
}

extension GameNode{
	public convenience init(named name: String, x: Float = 0, y: Float, z: Float, rotation: SIMD3<Float> = .zero, scale: SIMD3<Float> = .one){
 		self.init(named: name)
 		self.position = SIMD3(x, y, z)
		self.rotation = rotation
		self.scale = scale
	}
	
	public convenience init(named name: String, x: Float = 0, y: Float, z: Float, rotation: SIMD3<Float> = .zero, scale: SIMD3<Float> = .one, @GameNodesBuilder _ builder: () -> [GameNode]){
		self.init(named: name)
		self.position = SIMD3(x, y, z)
		self.rotation = rotation
		self.scale = scale
		self.children = [:]
		AssembleNode(self, builder)
	}
}