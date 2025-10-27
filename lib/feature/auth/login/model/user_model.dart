class UserModel {
  int? id;
  String? username;
  String? email;
  String? phone;
  String? role;

  UserModel({this.id, this.username, this.email, this.phone, this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['id'] = id;
    json['username'] = username;
    json['email'] = email;
    json['phone'] = phone;
    json['role'] = role;
    return json;
  }
}