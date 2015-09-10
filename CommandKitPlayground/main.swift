import CommandKit

var manager = Manager()

manager.register("issue", "") { argv in
    print("Issues will be managed!")
    print(argv.arguments)
}

manager.register("issue edit", "") { argv in
    print("Issues will be edited!")
    print(argv.arguments)
}

manager.register("issue delete", "") { argv in
    print("Issues will be edited!")
    print(argv.arguments)
}

manager.run(arguments: ["issue", "foo", "bar"])