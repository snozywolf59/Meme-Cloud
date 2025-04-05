class User {
  static final User _instance = User._internal();

  String? id;
  String? name;
  String? email;
  String? avatar;
  String? token;

  User._internal();
  factory User() {
    return _instance;
  }

  void setUser(
    String id,
    String name,
    String email,
    String avatar,
    String token,
  ) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.avatar = avatar;
    this.token = token;
  }

  void clearUser() {
    id = null;
    name = null;
    email = null;
    avatar = null;
    token = null;
  }

  bool get isLoggedIn {
    return token != null;
  }
}


String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 10) {
    return 'Chào buổi sáng';
  } else if (hour < 14) {
    return 'Chào buổi trưa';
  } else if (hour < 17) {
    return 'Chào buổi chiều';
  } else {
    return 'Chào buổi tối';
  }
}
