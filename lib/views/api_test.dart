import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_shell/model/todo_model.dart';

class ApiTest extends StatefulWidget {
  const ApiTest({super.key});

  @override
  State<ApiTest> createState() => _ApiTestState();
}

class _ApiTestState extends State<ApiTest> {
  List<TodoModel> todo = [];

  Future<void> getData() async {
    print("Trying to fetch Data from API");
    String url = "https://jsonplaceholder.typicode.com/todos";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List rawTodoData = jsonDecode(response.body);
      setState(() => todo = rawTodoData.map((item) => TodoModel.fromJson(item)).toList());
    } else {
      print("ERROR");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(onPressed: getData, label: Text("Get Data")),
            Text("Total length of Todo: ${todo.length}"),
            Expanded(
              child: ListView.builder(
                itemCount: todo.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(todo[index].title), trailing: todo[index].completed ? Icon(Icons.done) : Icon(Icons.cancel_outlined));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
