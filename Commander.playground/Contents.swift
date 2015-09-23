import Commander

let group = Group {
  $0.command("login") { (username:String) in
    print("You are now logged in \(username).")
  }

  $0.command("logout") {
    print("You are not logged out.")
  }
}

group.run([])
group.run(["login", "kyle"])
group.run(["logout"])
