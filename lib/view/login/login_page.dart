import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_lovepeople/core/functions.dart';
import 'package:todo_lovepeople/presenter/login_controller.dart';
import 'package:todo_lovepeople/view/home/home_page.dart';
import 'package:todo_lovepeople/view/register/register_page.dart';
import 'package:dotted_line/dotted_line.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  bool _isObscure = true;
  bool _validate = false;

  var suffixIcon;

  @override
  void initState() {
    postFrame(() {
      context.read<LoginController>().verifyLogin(_goHome);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginController>(
        builder: (context, controller, _) {
          return Center(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            width: 400,
                            height: 220,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(300),
                                bottomRight: Radius.circular(300),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 450,
                                  height: 175,
                                  child: Image.asset(
                                    'images/logo.png',
                                  ),
                                ),
                                const Text(
                                  'Lovepeople',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat-Bold',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(49, 1, 185, 1)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 100),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Center(
                                    child: Text(
                                      'Que bom que voltou!',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                                    hintText:
                                        'Número de telefone, email ou CPF',
                                    hintStyle: TextStyle(color: Colors.indigo),
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(left: 15),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: senhaController,
                                  obscureText: _isObscure,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Este campo é obrigatório';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
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
                                    hintStyle:
                                        const TextStyle(color: Colors.indigo),
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding:
                                        const EdgeInsets.only(left: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Esqueceu seu login ou senha?',
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Clique Aqui',
                                    style: TextStyle(color: Colors.yellow),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
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
                                String email = emailController.text;
                                String senha = senhaController.text;
                                if (email.isNotEmpty && senha.isNotEmpty) {
                                  controller.login(email, senha,
                                      onSuccess: _goHome,
                                      onFailure: _showError);
                                }

                                Navigator.of(context)
                                    .pushReplacementNamed('/lista');
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text(
                                'Entrar',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'Montserrat-SemiBold',
                                ),
                              ),
                            ),
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
                                  'Não possui cadastro?',
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextButton(
                                  child: const Text(
                                    'Clique Aqui',
                                    style: TextStyle(color: Colors.yellow),
                                  ),
                                  onPressed: () {
                                    _goRegister();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  void _goHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  void _showError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Email ou senha invalidos!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _goRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegisterPage(),
      ),
    );
  }
}
