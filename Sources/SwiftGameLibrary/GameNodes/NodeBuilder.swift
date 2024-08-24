import SwiftGameTypes

@resultBuilder
public enum GameNodesBuilder{
	public static func buildBlock(_ components: any GameNode...)->[any GameNode] {
		components
	}
}

public func AssembleNode(_ ownerNode: any GameNode, @GameNodesBuilder _ builder: () -> [any GameNode]){
	builder().forEach{
		ownerNode.add(child: $0)
	}
}

public func AssembleScene(_ scene: any GameScene, @GameNodesBuilder _ builder: () -> [any GameNode]){
	builder().forEach{
		scene.add(child: $0)
	}
}
