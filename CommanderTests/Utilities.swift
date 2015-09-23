import XCTest

func assertRaises(@autoclosure closure:() throws -> ()) {
  do {
    try closure()
    XCTFail("Expected error")
  } catch {
    // Success
  }
}
