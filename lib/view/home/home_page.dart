import 'package:flutter/material.dart';
import 'package:todo_lovepeople/core/functions.dart';
import 'package:provider/provider.dart';
import 'package:todo_lovepeople/model/repository/user_repository.dart';
import 'package:todo_lovepeople/model/todo.dart';
import 'package:todo_lovepeople/presenter/home_controller.dart';
import 'package:todo_lovepeople/view/login/login_page.dart';
import 'package:todo_lovepeople/view/new_todo/new_todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> listaFiltro = [];

  @override
  void initState() {
    postFrame(() {
      context.read<HomeController>().loadTodoList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, _) {
        return Scaffold(
          body: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        _Logo(),
                        Texto('Suas Listagens'),
                        Positioned(
                          top: 55,
                          right: 50,
                          child: IconButton(
                            onPressed: () {
                              context
                                  .read<UserRepository>()
                                  .logout()
                                  .then((value) {
                                _goLogin();
                              });
                            },
                            icon: Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(60, 35, 60, 10),
                child: TextField(
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 49, 1, 185)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 49, 1, 185)),
                    hintText: 'Busque palavras-chave',
                    suffixIcon: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 49, 1, 185),
                      size: 35,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  onChanged: (text) {
                    controller.filter(text);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.todoList.length,
                  itemBuilder: (context, index) {
                    final todo = controller.todoList[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: _getColor(todo
                                  .color), // cor de fundo para alterar no item.color
                            ),
                            child: ListTile(
                              title: Text(
                                todo.title ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 49, 1, 185),
                                ),
                              ),
                              subtitle: Text(
                                todo.description ?? '', // Corpo da tarefa
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 49, 1, 185),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              iconSize: 35,
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Color.fromARGB(255, 49, 1, 185),
                              ),
                              onPressed: () {
                                _showDialogDelete(controller, todo);
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: IconButton(
                  iconSize: 85,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () => _goRegisterTodo(controller),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _goLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void _goRegisterTodo(HomeController controller) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewTodoPage(),
      ),
    );

    if (result != null) {
      controller.loadTodoList();
    }
  }

  Color _getColor(String? color) {
    try {
      return Color(int.parse('0xFF${color?.replaceAll('#', '')}'));
    } catch (e) {
      return Colors.transparent;
    }
  }

  void _showDialogDelete(HomeController controller, Todo todo) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color.fromARGB(125, 232, 197, 255),
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          title: Text(
            "Deseja deletar este item?                             ",
            style: TextStyle(
              color: Color.fromARGB(255, 49, 1, 185),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Text(
            '"${todo.title}" será movido para lixeira.',
            style: const TextStyle(
              color: Color.fromARGB(255, 49, 1, 185),
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              child: new Text(
                "Confirmar",
                style: TextStyle(
                  color: Color.fromARGB(255, 49, 1, 185),
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                controller.delete(todo);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: new Text(
                "Cancelar",
                style: TextStyle(
                  color: Color.fromARGB(255, 49, 1, 185),
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

Widget _Logo() {
  return Container(
    width: 90,
    height: 90,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(90)),
    ),
    padding: const EdgeInsets.only(right: 20, bottom: 20),
    child: Image.asset('images/logo.png'),
  );
}

class Texto extends StatelessWidget {
  String texto;

  Texto(this.texto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Text(
            texto,
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
