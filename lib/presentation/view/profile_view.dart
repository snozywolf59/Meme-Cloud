import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String fullName = "Nguyễn Văn A";
  String userEmail = "nguyenvana@gmail.com";
  String userAvatarUrl = "https://randomuser.me/api/portraits/men/1.jpg";

  late TextEditingController fullNameController;
  late TextEditingController emailController;

  @override
  void initState() {
    fullNameController = TextEditingController(text: fullName);
    emailController = TextEditingController(text: userEmail);
    super.initState();
  }

  Future<void> _changeName() async {
    final newName = await showDialog<String>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Đổi tên'),
            content: TextField(
              decoration: InputDecoration(hintText: "Nhập tên mới"),
              controller: fullNameController,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Hủy'),
              ),
              TextButton(
                onPressed: () {
                  final newName =
                      (context as Element)
                              .findAncestorWidgetOfExactType<AlertDialog>()!
                              .content
                          as TextField;
                  Navigator.pop(
                    context,
                    (newName.controller as TextEditingController).text,
                  );
                },
                child: Text('Lưu'),
              ),
            ],
          ),
    );

    if (newName != null && newName.isNotEmpty) {
      setState(() {
        fullName = newName;
      });
    }
  }

  Future<void> _changeAvatar() async {
    // Trong thực tế, bạn sẽ thêm logic để chọn ảnh từ gallery hoặc chụp ảnh mới
    // Đây chỉ là ví dụ đơn giản
    final newAvatar = await showDialog<String>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Đổi avatar'),
            content: Text('Bạn muốn chọn ảnh từ thư viện hay chụp ảnh mới?'),
            actions: [
              TextButton(
                onPressed: () {
                  // Giả lập chọn ảnh từ thư viện
                  Navigator.pop(
                    context,
                    "https://randomuser.me/api/portraits/men/${DateTime.now().second % 100}.jpg",
                  );
                },
                child: Text('Thư viện'),
              ),
              TextButton(
                onPressed: () {
                  // Giả lập chụp ảnh mới
                  Navigator.pop(
                    context,
                    "https://randomuser.me/api/portraits/women/${DateTime.now().second % 100}.jpg",
                  );
                },
                child: Text('Chụp ảnh'),
              ),
            ],
          ),
    );

    if (newAvatar != null) {
      setState(() {
        userAvatarUrl = newAvatar;
      });
    }
  }

  Future<void> _changePassword() async {
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Đổi mật khẩu'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Mật khẩu hiện tại"),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Mật khẩu mới"),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Nhập lại mật khẩu mới",
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Hủy'),
              ),
              TextButton(
                onPressed: () {
                  // Thêm logic xác thực và đổi mật khẩu ở đây
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Đổi mật khẩu thành công!')),
                  );
                },
                child: Text('Lưu'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hồ sơ cá nhân'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(userAvatarUrl),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: _changeAvatar,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Họ và tên'),
                subtitle: Text(fullName),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: _changeName,
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.email),
                title: Text('Email'),
                subtitle: Text(userEmail),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.lock),
              label: Text('Đổi mật khẩu'),
              onPressed: _changePassword,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
