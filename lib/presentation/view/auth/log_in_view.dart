import 'package:flutter/material.dart';
import 'package:meme_cloud/data/models/auth/sign_in_request.dart';
import 'package:meme_cloud/domain/usecases/auth/sign_in.dart';
import 'package:meme_cloud/presentation/view/dashboard.dart';
import 'package:meme_cloud/core/service_locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Mật khẩu'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextButton(
              child: const Text(
                'Quên mật khẩu?',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () async {},
            ),
            ElevatedButton(
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
                    print(Supabase.instance.client.auth.currentUser);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashBoard(),
                      ),
                      (route) => false,
                    );
                  },
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
