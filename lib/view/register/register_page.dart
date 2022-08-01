import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_lovepeople/presenter/register_controller.dart';
import 'package:todo_lovepeople/view/home/home_page.dart';
import 'package:validatorless/validatorless.dart';

import '../complete/complete_page.dart';
import '../login/login_page.dart';
import '../new_todo/new_todo_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final confirmacaoController = TextEditingController();
  bool _isObscure = true;
  bool _isObscureTwo = true;
  var suffixIcon;

  var body;
  get onPressed => null;
  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RegisterController>(
        builder: (context, controller, _) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(80),
                  child: Text(
                    'Vamos começar!',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 252, 252, 253),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Este campo é obrigatório';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(14),
                              ),
                            ),
                            hintText: 'Nome',
                            hintStyle: TextStyle(color: Colors.indigo),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 15),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Este campo é obrigatório';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(14),
                              ),
                            ),
                            hintText: 'Número de telefone, email ou CPF',
                            hintStyle: TextStyle(color: Colors.indigo),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 15),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          obscureText: _isObscure,
                          controller: passwordController,
                          validator: Validatorless.multiple([
                            Validatorless.required('Senha obrigatória'),
                            Validatorless.min(
                                8, 'Senha de pelo menos 8 caracteres'),
                          ]),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(14),
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye_sharp,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                            hintText: 'Senha',
                            hintStyle: TextStyle(color: Colors.indigo),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 15),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          obscureText: _isObscureTwo,
                          controller: confirmacaoController,
                          validator: Validatorless.multiple([
                            Validatorless.required(
                                'Confirmação de senha obrigatória'),
                            Validatorless.min(
                                8, 'Senha de pelo menos 8 caracteres'),
                            Validators.compare(
                                passwordController, 'Senhas diferentes')
                          ]),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(14),
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscureTwo
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye_sharp,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscureTwo = !_isObscureTwo;
                                });
                              },
                            ),
                            hintText: 'Confirmação senha',
                            hintStyle: TextStyle(color: Colors.indigo),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 15),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(49, 1, 185, 1)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    side: const BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState?.validate() == true) {
                                  String name = nameController.text;
                                  String email = emailController.text;
                                  String password = passwordController.text;
                                  if (name.isNotEmpty &&
                                      email.isNotEmpty &&
                                      password.isNotEmpty) {
                                    controller.register(name, email, password,
                                        onSuccess: _goComplete,
                                        onFailure: _showError);
                                  }
                                }
                                Navigator.of(context)
                                    .pushReplacementNamed('/concluido');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Cadastrar',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 4.0,
                            dashColor: Colors.white,
                            dashRadius: 0.0,
                            dashGapLength: 4.0,
                            dashGapColor: Colors.transparent,
                            dashGapRadius: 0.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Já possui cadastro?',
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                child: const Text(
                                  'Entrar',
                                  style: TextStyle(color: Colors.yellow),
                                ),
                                onPressed: () {
                                  _goLogin();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _goComplete() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => Concluido(),
      ),
      (route) => false,
    );
  }

  void _goLogin() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
      (route) => false,
    );
  }

  void _showError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Não foi possivel realizar o cadastro',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
