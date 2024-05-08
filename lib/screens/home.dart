import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/constans/color.dart';
import 'package:todo_app/constans/tasktype.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/screens/addnewtask.dart';
import 'package:todo_app/service/todo_service.dart';
import 'package:todo_app/todoitem.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
// List<String> todo = ["Study LEssons", "Run 5K", " Go to party"];
// List<String> endedTodo = ["Game meetup", "Take out trash"];

class _HomePageState extends State<HomePage> {
  List<Task> todo = [
    Task(
      title: "Study Lessons",
      description: "Study Mat",
      inCompleted: false,
      type: TaskType.note,
    ),
    Task(
      title: "Run 5K",
      description: "4:00pm",
      inCompleted: false,
      type: TaskType.contest,
    ),
    Task(
      title: "Go to party",
      description: "10:00pm",
      inCompleted: false,
      type: TaskType.celendar,
    ),
  ];

  List<Task> endedTodo = [
    Task(
      title: "Run 5K",
      description: "4:00pm",
      inCompleted: false,
      type: TaskType.contest,
    ),
    Task(
      title: "Go to party",
      description: "10:00pm",
      inCompleted: false,
      type: TaskType.celendar,
    ),
  ];

  void addNewTask(Task newTask) {
    setState(() {
      todo.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    TodoService todoService = TodoService();

    double _phoneWidth = MediaQuery.of(context).size.width;
    double _phoneHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: HexColor(backgroundColor),
          body: Column(
            children: [
              //Header
              Container(
                width: _phoneWidth,
                height: _phoneHeight / 3,
                decoration: const BoxDecoration(
                    color: Colors.purple,
                    image: DecorationImage(
                        image: AssetImage("lib/assets/images/header.png"),
                        fit: BoxFit.cover)),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "october 20, 2025",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        "My todo list",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              // top Column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SingleChildScrollView(
                    child: FutureBuilder(
                      future: todoService.getUncompletedTodos(),
                      builder: (context, snapshot) {
                        print(snapshot.data);
                        if (snapshot.data == null) {
                          return const CircularProgressIndicator();
                        } else {
                          return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return TodoItem(
                                task: snapshot.data![index],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              // Completed text
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Completed",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              // bottom column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SingleChildScrollView(
                      child: FutureBuilder(
                    future: todoService.getCompletedTodos(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                          return const CircularProgressIndicator();
                        } else {
                          return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return TodoItem(
                                task: snapshot.data![index],
                              );
                            },
                          );
                        }
                    },
                  )),
                ),
              ),
              ElevatedButton(
                onPressed: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddNewTaskPage(
                      addNewTask: (newTask) => addNewTask(newTask),
                    ),
                  ))
                },
                child: const Text("Add New Task"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
