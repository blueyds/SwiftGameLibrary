public enum Log{
	static let separator: String = ":::"
	static func info(_ msg: String ...){
		let message = msg.reduce("",reduce(_:_:))
		print("INFO: \(message)")
	}
	
	static func error(_ msg: String ...){
		let message = msg.reduce("",reduce(_:_:))
		print("ERROR: \(message)")
	}
	static func fatalError(_ msg: String ...){
		let message = msg.reduce("",reduce(_:_:))
		fatalError("\(message)")
	}
	
	static private func reduce(_ initial: String, _ next: String)->String{
		var result = initial
		result.append(contentsOf: next)
		result.append(Log.separator)
		return result
	}
}