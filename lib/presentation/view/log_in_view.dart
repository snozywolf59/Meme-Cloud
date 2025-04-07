import 'package:flutter/material.dart';
import 'package:meme_cloud/data/models/sign_in_request.dart';
import 'package:meme_cloud/domain/usecases/auth/sign_in.dart';
import 'package:meme_cloud/presentation/view/dashboard.dart';
import 'package:meme_cloud/service_locator.dart';

class LogInView extends StatelessWidget {
  LogInView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Text(
              'Đăng Nhập',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Mật khẩu'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextButton(
              child: Text(
                'Quên mật khẩu?',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () async {
                var result = await serviceLocator<SignInUseCase>().call(
                  SignInRequest(
                    email: emailController.text.toString(),
                    password: passwordController.text.toString(),
                  ),
                );
                result.fold(
                  (l) {
                    // Handle error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Đăng nhập thất bại: $l')),
                    );
                  },
                  (r) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => DashBoard()),
                      (route) => false,
                    );
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DashBoard()),
                  (route) => false,
                );
              },
              child: const Text(
                'Đăng nhập',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
