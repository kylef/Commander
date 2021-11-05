#if compiler(>=5.5)
/// Represents an async command that can be run, given an argument parser
public protocol AsyncCommandType {
	//run the command with an array of arguments
	@available(macOS 12, *)
	func run(_ parser:ArgumentParser) async throws
}

extension AsyncCommandType {
	///run the async command with an array of arguments
	@available(macOS 12, *)
	public func run(_ arguments:[String]) async throws {
		try await run(ArgumentParser(arguments:arguments))
	}
}
#endif