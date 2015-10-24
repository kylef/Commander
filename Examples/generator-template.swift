/// Automatically generated file from Examples/generator.swift

// MARK: Commands

{% for command in commands %}
/// Create a command which takes {{ command.count }} argument using a closure
public func command<A:ArgumentConvertible{% for a in command.arguments %}, A{{ a }}:ArgumentConvertible{% endfor %}>(closure:(A{% for a in command.arguments %}, A{{ a }}{% endfor %}) throws-> ()) -> CommandType {
  return AnonymousCommand { parser in
    try closure(try A(parser: parser){% for a in command.arguments %}, try A{{ a }}(parser: parser){% endfor %})
  }
}
{% endfor %}

// MARK: Argument Descriptor Commands

{% for command in commands %}
/// Create a command which takes {{ command.count }} argument using a closure with arguments
public func command<A:ArgumentDescriptor{% for a in command.arguments %}, A{{ a }}:ArgumentDescriptor{% endfor %}>(descriptor:A{% for a in command.arguments %}, _ descriptor{{ a }}:A{{ a }}{% endfor %}, closure:(A.ValueType{% for a in command.arguments %}, A{{ a }}.ValueType{% endfor %}) throws -> ()) -> CommandType {
  return AnonymousCommand { parser in
    if parser.hasOption("help") {
      throw Help([
        BoxedArgumentDescriptor(value: descriptor),{% for a in command.arguments %}
        BoxedArgumentDescriptor(value: descriptor{{ a }}),{% endfor %}
      ])
    }

    try closure(try descriptor.parse(parser){% for a in command.arguments %}, try descriptor{{ a }}.parse(parser){% endfor %})
  }
}
{% endfor %}

// MARK: Group commands

extension Group {
  // MARK: Argument Description Commands

  /// Add a command which takes no argument using a closure
  public func command(name:String, closure:() throws -> ()) {
    addCommand(name, Commander.command(closure))
  }
{% for command in commands %}
  /// Add a command which takes {{ command.count }} arguments using a closure
  public func command<A:ArgumentConvertible{% for a in command.arguments %}, A{{ a }}:ArgumentConvertible{% endfor %}>(name:String, closure:(A{% for a in command.arguments %}, A{{ a }}{% endfor %}) throws -> ()) {
    addCommand(name, Commander.command(closure))
  }
{% endfor %}
  // MARK: Argument Descriptor Commands

{% for command in commands %}
  /// Add a command which takes {{ command.count }} arguments using a closure
  public func command<A:ArgumentDescriptor{% for a in command.arguments %}, A{{ a }}:ArgumentDescriptor{% endfor %}>(name: String, _ descriptor: A{% for a in command.arguments %}, _ descriptor{{ a }}: A{{ a }}{% endfor %}, closure: (A.ValueType{% for a in command.arguments %}, A{{ a }}.ValueType{% endfor %}) throws -> ()) {
    addCommand(name, Commander.command(descriptor,{% for a in command.arguments %} descriptor{{ a }}, {% endfor %} closure: closure))
  }
{% endfor %}
}

