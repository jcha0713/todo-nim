import os, jester, nimja

type Todo = object
  id: int
  description: string
  done: bool

var todos = @[
  Todo(id: 1, description: "clean the room", done: false),
  Todo(id: 2, description: "call your mom", done: false),
  Todo(id: 3, description: "go to bed early", done: false),
]

proc renderIndex(todos: seq[Todo]): string =
  compileTemplateFile(getScriptDir() / "template/index.nimja")


routes:
  get "/":
    resp renderIndex(todos)
