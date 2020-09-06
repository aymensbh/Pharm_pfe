class User {
  int id;
  String username, password;

  User({this.id, this.username, this.password});

  User.fromMap(Map<String, dynamic> map) {
    id = map["user_id"];
    username = map["user_name"];
    password = map["user_password"];
  }

  Map<String, dynamic> toMap() {
    return {
      "user_id": id,
      "user_name": username,
      "user_password": password,
    };
  }

  bool login(String username, String password) {
    //TODO login
  }

  bool signup() {
    //TODO signup
  }
}
