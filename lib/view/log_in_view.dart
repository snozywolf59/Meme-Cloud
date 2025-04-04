import 'package:flutter/material.dart';
import 'package:meme_cloud/auth/user_provider.dart';
import 'package:meme_cloud/view/dashboard.dart';
import 'package:meme_cloud/view/home_view.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log In')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome back!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const DashBoard()),
                  (route) => false,
                );
              },
              child: const Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}
