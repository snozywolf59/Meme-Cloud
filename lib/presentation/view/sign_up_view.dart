import 'package:flutter/material.dart';
import 'package:meme_cloud/data/models/create_user_request.dart';
import 'package:meme_cloud/domain/usecases/auth/sign_up.dart';
import 'package:meme_cloud/presentation/view/log_in_view.dart';
import 'package:meme_cloud/service_locator.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
              'Đăng Ký',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: fullNameController,
              decoration: const InputDecoration(labelText: 'Họ và tên'),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(labelText: 'Nhập lại mật khẩu'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            const Text(
              'Bằng việc đăng ký, bạn đồng ý với các điều khoản và chính sách của chúng tôi.',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (passwordController.text != confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mật khẩu không khớp!')),
                  );
                  return;
                }
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty ||
                    fullNameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Vui lòng điền đầy đủ thông tin!'),
                    ),
                  );
                  return;
                }
                if (passwordController.text.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Mật khẩu phải có ít nhất 6 ký tự!'),
                    ),
                  );
                  return;
                }
                if (!RegExp(
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                ).hasMatch(emailController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Email không hợp lệ!')),
                  );
                  return;
                }
                if (passwordController.text != confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mật khẩu không khớp!')),
                  );
                  return;
                }
                if (confirmPasswordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Vui lòng nhập lại mật khẩu!'),
                    ),
                  );
                  return;
                }
                if (confirmPasswordController.text.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Mật khẩu phải có ít nhất 6 ký tự!'),
                    ),
                  );
                  return;
                }
                if (!RegExp(
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                ).hasMatch(emailController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Email không hợp lệ!')),
                  );
                  return;
                }
                var result = await serviceLocator<SignupUseCase>().call(
                  CreateUserRequest(
                    email: emailController.text.toString(),
                    password: passwordController.text.toString(),
                    fullName: fullNameController.text.toString(),
                  ),
                );
                result.fold(
                  (l) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Đăng ký không thành công! Lỗi $l'),
                      ),
                    );
                  },
                  (r) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đăng ký thành công!')),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LogInView()),
                    );
                  },
                );
              },
              child: const Text(
                'Đăng ký',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
