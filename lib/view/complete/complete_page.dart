import 'package:flutter/material.dart';

class Concluido extends StatefulWidget {
  const Concluido({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConcluidoState();
}

class _ConcluidoState extends State<Concluido> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                const Center(
                  child: Text(
                    'Cadastro concluído!',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Começar',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Montserrat-SemiBold',
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(49, 1, 185, 1)),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 8)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side:
                              const BorderSide(width: 2, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 210),
            Container(
              width: 400,
              height: 230,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(300),
                  topRight: Radius.circular(300),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: 450,
                    height: 190,
                    child: Image.asset(
                      'images/pose.png',
                    ),
                  ),
                  const Text(
                    'Os ventos da programação estão indo até você',
                    style: TextStyle(
                        fontFamily: 'Montserrat-Bold',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(49, 1, 185, 1)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
