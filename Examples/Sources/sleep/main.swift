import Commander

let sleep = command(
) { (seconds: Double) in
  try await Task.sleep(nanoseconds: UInt64(seconds * Double(1000000000)))
}

await sleep
