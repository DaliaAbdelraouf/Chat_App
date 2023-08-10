class UserModel {
  String? name;
  String? email;
  String? avatar;
  DateTime? dateTime;

  UserModel({this.name, this.email, this.avatar, this.dateTime});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        email: json['email'],
        avatar: json['avatar'],
        dateTime: DateTime.now());
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'avatar': avatar,
      'dateTime': dateTime,
    };
  }
}
