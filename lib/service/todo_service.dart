import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_app/model/todo.dart';

class TodoService {
  final String baseUrl = "https://dummyjson.com/todos";
  //diğerlerini de türeteceğimiz base url

  Future<List<Todo>> getUncompletedTodos() async {
    // ASENKRON ÇALIŞAN GET METODU İÇİN ASYNC KEYWORD KOYDUK
    //VE İLK ALDIĞIMIZ RESPONSE'A AWAİT DEDİK
    // APİNİN BİR CEVAP SÜRESİ OLDUĞUNDAN DÖNÜŞ TİPİNİ FUTURE YAPTIK Kİ ONU BEKLEMEYELİM
    //ARDINDAN DİNAMİK RESP LİSTESİNİ RESPONSE İLE DOLDURUP
    //BU JSONU TODO.FROMJSON YAPARAK TODOYA UYGUN ŞEKLE GETİRİP LİSTELEDİK
    final response = await http.get(Uri.parse(baseUrl));
    List<dynamic> resp = jsonDecode(response.body)["todos"];
    List<Todo> todos = List.empty(growable: true);
    resp.forEach((element) {
      Todo task = Todo.fromJson(element);
      // task.completed! ? todos.add(task) : ;
      if (task.completed! == false) {
        todos.add(task);
      }
    });

    return todos;
  }

  Future<List<Todo>> getCompletedTodos() async {
    final response = await http.get(Uri.parse(baseUrl));
    List<dynamic> resp = jsonDecode(response.body)["todos"];
    List<Todo> todos = List.empty(growable: true);

    resp.forEach(
      (element) {
        Todo task = Todo.fromJson(element);

        if (task.completed!) {
          todos.add(task);
        }
      },
    );
    return todos;
  }
}
