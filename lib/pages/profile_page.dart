import 'package:flutter/material.dart';
import 'package:flutter_review_app/models/user_model.dart';
import 'package:flutter_review_app/pages/edit_image_page.dart';
import 'package:flutter_review_app/repository/user_repository.dart';
import 'package:flutter_review_app/widgets/display_image_widget.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  _getUser() async {
    UserModel user = await context.read<UserRepository>().getUserInfo();
    name.value = TextEditingValue(text: user.name);
    email.value = TextEditingValue(text: user.email);
    phone.value = TextEditingValue(text: user.phone);
  }

  @override
  Widget build(BuildContext context) {
    saveUser() async {
      try {
        await context
            .read<UserRepository>()
            .copyUser(name: name.text, phone: phone.text, email: '');
        await context.read<UserRepository>().saveUserInfo();
      } on Exception catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

    return Scaffold(
        backgroundColor: Colors.white10,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AppBar(
                        backgroundColor: const Color.fromARGB(255, 255, 57, 57),
                        foregroundColor: Colors.white,
                        title: const Text('Edit Profile'),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditImagePage()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Consumer<UserRepository>(
                                builder: (context, userRepository, _) {
                              return DisplayImage(
                                imagePath: userRepository.userModel.image,
                              );
                            }),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: TextFormField(
                            controller: name,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid)),
                              labelText: 'Nome',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe o Nome Corretamente';
                              }
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: TextFormField(
                            controller: email,
                            readOnly: true,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid)),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe o Email Corretamente';
                              }
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: TextFormField(
                            controller: phone,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid)),
                              labelText: 'Telefone',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe o Telefone Corretamente';
                              }
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              saveUser();
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.save),
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  'Salvar',
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))));
  }
}
