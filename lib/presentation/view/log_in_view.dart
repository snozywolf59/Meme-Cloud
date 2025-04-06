import 'package:flutter/material.dart';
import 'package:meme_cloud/presentation/view/dashboard.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

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
            const TextField(decoration: InputDecoration(labelText: 'Email')),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(labelText: 'Mật khẩu'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextButton(
              child: Text(
                'Quên mật khẩu?',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {},
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DashBoard()),
                  (route) => false,
                );
              },
              child: const Text('Đăng nhập', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
