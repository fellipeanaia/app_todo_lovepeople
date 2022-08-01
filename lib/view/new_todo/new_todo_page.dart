import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_lovepeople/model/todo.dart';
import 'package:todo_lovepeople/presenter/new_todo_controller.dart';

class NewTodoPage extends StatefulWidget {
  const NewTodoPage({Key? key}) : super(key: key);

  @override
  _NewTodoPageState createState() => _NewTodoPageState();
}

class _NewTodoPageState extends State<NewTodoPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final todoColors = ['#FFF2CC', '#FFD9F0', '#E8C5FF', '#CAFBFF', '#E3FFE6'];
  String colorSelected = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<NewTodoController>(builder: (context, controller, _) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      _Logo(),
                      Texto('Nova Tarefa'),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(60, 35, 60, 10),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    TextField(
                      controller: titleController,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 49, 1, 185),
                      ),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle:
                            TextStyle(color: Color.fromARGB(255, 49, 1, 185)),
                        hintText: 'Título da Tarefa',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: descriptionController,
                      maxLines: 8,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 232, 197, 255),
                      ),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 232, 197, 255)),
                        hintText: 'Escreva uma descrição para sua tarefa',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    _buildColors(),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: IconButton(
                              iconSize: 80,
                              icon: const Icon(
                                Icons.close_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: IconButton(
                                iconSize: 80,
                                icon: const Icon(
                                  Icons.done_outlined,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  String title = titleController.text;
                                  String description =
                                      descriptionController.text;

                                  if (title.isNotEmpty &&
                                      description.isNotEmpty) {
                                    final todo = Todo(
                                      title: title,
                                      description: description,
                                      color: colorSelected,
                                    );
                                    controller.registerTodo(
                                      todo,
                                      onSuccess: () {
                                        Navigator.of(context).pop(todo);
                                      },
                                      onFailure: _showError,
                                    );
                                  }
                                }),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _buildColors() {
    return Container(
      height: 75,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          final on = todoColors[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                colorSelected = on;
              });
            },
            child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(
                    int.parse('0xFF${on.replaceAll('#', '')}'),
                  ),
                  border: colorSelected == on
                      ? Border.all(
                          color: const Color.fromARGB(255, 49, 1, 185),
                          width: 3,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: colorSelected == on
                    ? Image.asset('images/logo.png')
                    : null),
          );
        },
      ),
    );
  }

  void _showError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Não foi possivel cadastrar TODO',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
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
