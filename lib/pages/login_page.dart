import 'package:flutter/material.dart';
import 'package:flutter_review_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  bool isLogin = true;
  late String title;
  late String actionButton;
  late String toggleButton;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool formAction) {
    setState(() {
      isLogin = formAction;
      if (isLogin) {
        title = 'Bem vindo';
        actionButton = 'Login';
        toggleButton = 'Cadastre-se agora.';
      } else {
        title = 'Crie sua conta';
        actionButton = 'Cadastrar';
        toggleButton = 'Voltar ao Login';
      }
    });
  }

  login() async {
    try {
      await context.read<AuthService>().login(email.text, password.text);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  register() async {
    try {
      await context.read<AuthService>().register(email.text, password.text);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 44, 44, 48),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color.fromARGB(255, 44, 44, 48), Colors.black],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 500,
                    height: 120,
                    child: Image.asset("assets/images/textBox.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: TextFormField(
                        controller: email,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0)),
                        decoration: const InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255))),
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          labelStyle:
                              TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informe o email Corretamente';
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: TextFormField(
                        controller: password,
                        obscureText: true,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0)),
                        decoration: const InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255))),
                          border: OutlineInputBorder(),
                          labelText: 'Senha',
                          labelStyle:
                              TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informe sua senha';
                          } else if (value.length < 6) {
                            return 'Sua senha deve ter no minimo 6 caracteres';
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (isLogin) {
                            login();
                          } else {
                            register();
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              actionButton,
                              style: const TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => setFormAction(!isLogin),
                    child: Text(toggleButton),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
