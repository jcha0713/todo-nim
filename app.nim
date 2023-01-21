import std/sequtils, strutils, algorithm
import os, jester, nimja

type Todo = ref object
  id: int
  description: string
  done: bool

var
  id = 4
  todos = @[
    Todo(id: 1, description: "clean the room", done: false),
    Todo(id: 2, description: "call your mom", done: false),
    Todo(id: 3, description: "go to bed early", done: false),
  ]

proc addTodo(todo: Todo) =
  todos.add(todo)

proc deleteTodo(id: int): void =
  todos = filter(todos, proc(item: Todo): bool = item.id != id)

proc editTodo(id: int, content: string) =
  for item in todos:
    if item.id == id:
      item.description = content

proc toggleDone(id: int) =
  for item in todos:
    if item.id == id:
      item.done = not item.done

proc renderIndex(todos: seq[Todo]): string =
  compileTemplateFile(getScriptDir() / "template/index.nimja")

routes:
  get "/":
    resp renderIndex(todos)

  post "/done/@id":
    var id = parseInt(@"id")
    toggleDone(id)
    redirect("/")

  post "/add":
    if @"todo".len > 0:
      addTodo(Todo(id: id, description: @"todo", done: false))
      id += 1
    redirect("/")

runForever()
