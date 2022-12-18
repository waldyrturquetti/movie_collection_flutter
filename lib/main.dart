import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_review_app/my_app.dart';
import 'package:flutter_review_app/repository/comment_repository.dart';
import 'package:flutter_review_app/repository/image_repository.dart';
import 'package:flutter_review_app/repository/user_repository.dart';
import 'package:flutter_review_app/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: '.env');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) =>
            CommentRepository(auth: context.read<AuthService>())
        ),
        ChangeNotifierProvider(create: (context) =>
            ImageRepository(auth: context.read<AuthService>())
        ),
        ChangeNotifierProvider(create: (context) =>
            UserRepository(auth: context.read<AuthService>())
        ),
      ],
      child: const MyApp(),
    ),
  );
}
