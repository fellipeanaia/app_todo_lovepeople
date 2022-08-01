import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_lovepeople/presenter/home_controller.dart';
import 'package:todo_lovepeople/presenter/login_controller.dart';
import 'package:todo_lovepeople/presenter/new_todo_controller.dart';
import 'package:todo_lovepeople/presenter/register_controller.dart';
import 'package:todo_lovepeople/view/login/login_page.dart';

import 'core/local_preferences.dart';
import 'model/repository/todo_repository.dart';
import 'model/repository/user_repository.dart';
import 'view/home/home_page.dart';
import 'view/new_todo/new_todo_page.dart';
import 'view/register/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const URL_BASE_API = 'https://todo-lovepeople.herokuapp.com';
  final preferences = LocalPreferences();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: TodoRepository(URL_BASE_API, preferences)),
        Provider.value(value: UserRepository(URL_BASE_API, preferences)),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => LoginController(context.read()),
          ),
          ChangeNotifierProvider(
            create: (context) => HomeController(context.read(), context.read()),
          ),
          ChangeNotifierProvider(
            create: (context) => RegisterController(context.read()),
          ),
          ChangeNotifierProvider(
            create: (context) => NewTodoController(context.read()),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 169, 1, 247),
          ),
          routes: {
            '/': (context) => LoginPage(),
            '/tela_cadastro': (context) => RegisterPage(),
            '/home': (context) => HomePage(),
            '/nova_tarefa': (context) => NewTodoPage(),
          },
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
