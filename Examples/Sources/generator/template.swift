/// Automatically generated file from Examples/generator.swift

// MARK: Commands

{% for command in commands %}
/// Create a command which takes {{ command.count_ }} argument using a closure
public func command<A:ArgumentConvertible{% for a in command.arguments %}, A{{ a }}:ArgumentConvertible{% endfor %}>(_ closure: @escaping (A{% for a in command.arguments %}, A{{ a }}{% endfor %}) throws-> ()) -> CommandType {
  return AnonymousCommand { parser in
    try closure(try A(parser: parser){% for a in command.arguments %}, try A{{ a }}(parser: parser){% endfor %})
  }
}
{% endfor %}

// MARK: Argument Descriptor Commands

{% for command in commands %}
/// Create a command which takes {{ command.count_ }} argument using a closure with arguments
public func command<A:ArgumentDescriptor{% for a in command.arguments %}, A{{ a }}:ArgumentDescriptor{% endfor %}>(_ descriptor:A{% for a in command.arguments %}, _ descriptor{{ a }}:A{{ a }}{% endfor %}, _ closure: @escaping (A.ValueType{% for a in command.arguments %}, A{{ a }}.ValueType{% endfor %}) throws -> ()) -> CommandType {
  return AnonymousCommand { parser in
    let help = Help([
        BoxedArgumentDescriptor(value: descriptor),{% for a in command.arguments %}
        BoxedArgumentDescriptor(value: descriptor{{ a }}),{% endfor %}
    ])

    if parser.hasOption("help") {
      throw help
    }

    let value0 = try descriptor.parse(parser){% for a in command.arguments %}
    let value{{ a }} = try descriptor{{ a }}.parse(parser){% endfor %}

    if !parser.isEmpty {
      throw UsageError("Unknown Arguments: \(parser)", help)
    }

    try closure(value0{% for a in command.arguments %}, value{{ a }}{% endfor %})
  }
}
{% endfor %}

// MARK: Group commands

extension Group {
  // MARK: Argument Description Commands

  /// Add a command which takes no argument using a closure
  public func command(_ name:String, description:String? = nil, _ closure: @escaping () throws -> ()) {
    addCommand(name, description, Commander.command(closure))
  }
{% for command in commands %}
  /// Add a command which takes {{ command.count_ }} arguments using a closure
  public func command<A:ArgumentConvertible{% for a in command.arguments %}, A{{ a }}:ArgumentConvertible{% endfor %}>(_ name: String, description: String? = nil, _ closure: @escaping (A{% for a in command.arguments %}, A{{ a }}{% endfor %}) throws -> ()) {
    addCommand(name, description, Commander.command(closure))
  }
{% endfor %}
  // MARK: Argument Descriptor Commands

{% for command in commands %}
  /// Add a command which takes {{ command.count_ }} arguments using a closure
  public func command<A:ArgumentDescriptor{% for a in command.arguments %}, A{{ a }}:ArgumentDescriptor{% endfor %}>(_ name: String, _ descriptor: A{% for a in command.arguments %}, _ descriptor{{ a }}: A{{ a }}{% endfor %}, description: String? = nil, _ closure: @escaping (A.ValueType{% for a in command.arguments %}, A{{ a }}.ValueType{% endfor %}) throws -> ()) {
    addCommand(name, description, Commander.command(descriptor,{% for a in command.arguments %} descriptor{{ a }}, {% endfor %} closure))
  }
{% endfor %}
}

