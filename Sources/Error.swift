#if os(Linux)
  import Glibc
#else
  import Darwin.libc
#endif


protocol ANSIConvertible : Error, CustomStringConvertible {
  var ansiDescription: String { get }
}


extension ANSIConvertible {
  func print() {
    // Check if Xcode Colors is installed and enabled.
    let xcodeColorsEnabled = (getEnvValue("XcodeColors") == "YES")
    if xcodeColorsEnabled {
      fputs("\(ansiDescription)\n", stderr)
    }
    
    // Check if we are in any term env and the output is a tty.
    let termType = getEnvValue("TERM")
    if let t = termType, t.lowercased() != "dumb" && isatty(fileno(stdout)) != 0 {
      fputs("\(ansiDescription)\n", stderr)
    } else {
      fputs("\(description)\n", stderr)
    }
  }

  private func getEnvValue(_ key: String) -> String? {
    guard let value = getenv(key) else {
      return nil
    }
    return String(cString: value)
  }
}


enum ANSI: UInt8, CustomStringConvertible {
  case reset = 0

  case black = 30
  case red
  case green
  case yellow
  case blue
  case magenta
  case cyan
  case white
  case `default`

  var description: String {
    return "\u{001B}[\(self.rawValue)m"
  }
}
