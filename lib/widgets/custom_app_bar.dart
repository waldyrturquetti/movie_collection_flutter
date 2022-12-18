import 'package:flutter/material.dart';
import 'package:flutter_review_app/pages/profile_page.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffSet;

  const CustomAppBar({super.key, this.scrollOffSet = 0.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      color: Color.fromARGB(255, 255, 57, 57),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const _AppBarButton(
                    title: 'Perfil',
                    page: ProfilePage(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () => context.read<AuthService>().logout(),
                    color: const Color.fromARGB(255, 252, 252, 252),
                    iconSize: 16,
                    splashRadius: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  final String title;
  final StatefulWidget page;

  const _AppBarButton({super.key, required this.title, required this.page});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
        style: const ButtonStyle(
            textStyle: MaterialStatePropertyAll(
                TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600))),
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 14, color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
    );
  }
}
