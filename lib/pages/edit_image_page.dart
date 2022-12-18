import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_review_app/repository/image_repository.dart';
import 'package:flutter_review_app/repository/user_repository.dart';
import 'package:flutter_review_app/widgets/display_image_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path_lib;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_review_app/models/user_model.dart';
import 'package:provider/provider.dart';

class EditImagePage extends StatefulWidget {
  const EditImagePage({Key? key}) : super(key: key);

  @override
  State<EditImagePage> createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  var user = UserModel.myUser;

  saveImage() async {
    try {
      String imageURL =
          await context.read<ImageRepository>().upload(user.image);
      user = await context
          .read<UserRepository>()
          .copyUser(imagePath: imageURL, email: '');
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AppBar(
            backgroundColor: const Color.fromARGB(255, 255, 57, 57),
            foregroundColor: Colors.white,
            title: const Text('Upload da Foto de Perfil'),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                  width: 330,
                  child: GestureDetector(
                    onTap: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (image == null) return;

                      final location = await getApplicationDocumentsDirectory();
                      final name = path_lib.basename(image.path);
                      final imageFile = File('${location.path}/$name');
                      final newImage =
                          await File(image.path).copy(imageFile.path);
                      setState(
                          () => {user = user.copy(imagePath: newImage.path)});
                    },
                    child: DisplayImage(
                      imagePath: user.image,
                    ),
                  ))),
          Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 330,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => saveImage(),
                      child: const Text(
                        'Update',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}
