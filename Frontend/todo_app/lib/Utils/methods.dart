import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../models/todo.dart';

class HelperFunctions {
  Future<List<dynamic>> fetchData() async {
    List<Todo> myTodos = [];
    final host = Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';
    final String apiUrl = 'http://$host:8000/'; // Adjust the endpoint as needed

    try {
      http.Response response = await http.get(Uri.parse(apiUrl));

      var data = json.decode(response.body);
      data.forEach((todo) {
        Todo t = Todo(
          date: todo['date'],
          id: todo['id'],
          title: todo['title'],
          description: todo['description'],
          isdone: todo['isdone'],
        );

        myTodos.add(t);
      });
      print(myTodos.length);
      
    } catch (e) {
      print(e);
    }
    return myTodos;
  }

  Future<void> deleteTodo(String id) async {
    final host = Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';
    final String apiUrl = 'http://$host:8000/$id/'; // Adjust the endpoint as needed

    try {
      http.Response response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 204) {
        fetchData();
      } else {
        print("Failed to delete todo: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  Future<void> postData({String title = "", String description = ""}) async {
    final host = Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';
    final String apiUrl = 'http://$host:8000/'; // Adjust the endpoint as needed
    try {
      http.Response response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'title': title,
            'description': description,
            'isdone': false.toString(),
          }));

      if (response.statusCode == 201) {
        fetchData();
      } else {
        print("Failed to add todo: ${response.statusCode}");
      }
    } catch (e) {
      print("Error is $e");
    }
  }

  Future<void> updateTodo({
    required String id,
    required String title,
    required String description,
    required bool isdone,
  }) async {
    final host = Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';
    final String apiUrl = 'http://$host:8000/$id/'; // Adjust the endpoint as needed

    try {
      http.Response response = await http.put(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': title,
          'description': description,
          'isdone': isdone,
        }),
      );
      if (response.statusCode == 200) {
        print('Todo updated');
      } else {
        print("Failed to update todo: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
