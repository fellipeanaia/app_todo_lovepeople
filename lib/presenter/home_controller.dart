import 'package:flutter/material.dart';
import 'package:todo_lovepeople/core/functions.dart';
import 'package:todo_lovepeople/model/login_response.dart';
import 'package:todo_lovepeople/model/repository/todo_repository.dart';
import 'package:todo_lovepeople/model/repository/user_repository.dart';
import 'package:todo_lovepeople/model/todo.dart';

class HomeController extends ChangeNotifier {
  final TodoRepository _repository;
  final UserRepository _userRepository;

  HomeController(this._repository, this._userRepository);

  List<Todo> todoList = [];
  List<Todo> _filterList = [];
  bool loading = false;
  LoginResponse? login;

  void filter(String keyWord) {
    todoList = _filterList
        .where((element) =>
            element.title!.toLowerCase().contains(keyWord.toLowerCase()) ||
            element.description!.toLowerCase().contains(keyWord.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void loadTodoList() async {
    _showLoading(true);

    login = await _userRepository.getLogin();

    _repository.getTodoList().then((value) {
      todoList = value;
      _filterList = value;
    }).whenComplete(() {
      _showLoading(false);
    });
  }

  void delete(Todo todo) {
    _showLoading(true);
    _repository.delete(todo.id).then((value) {
      if (value != null) {
        todoList.remove(todo);
      }
    }).whenComplete(() {
      _showLoading(false);
    });
  }

  void _showLoading(bool show) {
    postFrame(() {
      loading = show;
      notifyListeners();
    });
  }
}
