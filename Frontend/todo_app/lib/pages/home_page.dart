import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:todo_app/Widgets/todo_container.dart';
import 'package:todo_app/Widgets/app_bar.dart';
import '../models/todo.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:todo_app/Utils/methods.dart';

HelperFunctions helperFunctions = HelperFunctions();

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int done = 0;
  List<Todo> myTodos = [];
  bool isLoading = true;

  void _showModel() {
    String title = "";
    String description = "";
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 300,
        child: Center(
          child: Column(
            children: [
              Text("Add your Todo",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Title"),
                onChanged: (value) {
                  title = value;
                },
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Description"),
                onChanged: (value) {
                  description = value;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () async {
                    await helperFunctions.postData(title: title, description: description);
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: Text("Add"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteTodo(String id) async {
    await helperFunctions.deleteTodo(id);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 93, 149, 255),
      appBar: customAppBar(),
      body: FutureBuilder(
        future: helperFunctions.fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            myTodos = snapshot.data;
            done = myTodos.where((todo) => todo.isdone).length;
            return SingleChildScrollView(
              child: Column(
                children: [
                  PieChart(dataMap: {
                    "Done": done.toDouble(),
                    "Incomplete": (myTodos.length - done).toDouble(),
                  }),
                  Column(
                    children: myTodos.map((todo) {
                      return TodoContainer(
                        onPress: () => _deleteTodo(todo.id.toString()),
                        id: todo.id,
                        title: todo.title,
                        description: todo.description,
                        isdone: todo.isdone,
                        date: todo.date,
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text("No data available"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showModel,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Color.fromARGB(255, 93, 149, 255),
        ),
      ),
    );
  }
}
