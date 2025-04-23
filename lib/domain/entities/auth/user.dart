class AppUser {
  String? id;
  String? fullName;
  String? email;
  String? avatarUrl;

  AppUser({this.id, this.fullName, this.email, this.avatarUrl});

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] as String,
      fullName: json['display_name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String,
    );
  }
}
