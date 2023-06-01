class User {
  int? userId;
  String? username;
  String? email;
  String? password;
  String? token;
  String? first_name;
  String? last_name;

  User({
    this.userId,
    this.username,
    this.email,
    this.first_name,
    this.last_name,
    this.password,
    this.token,
  });

  // factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
  //       id: data['id'],
  //       username: data['username'],
  //       password: data['password'],
  //       token: data['token'],
  //     );

  
//   {
//     "pk": 4,
//     "username": "user4A",
//     "email": "u4@gmail.com",
//     "first_name": "",
//     "last_name": ""
// }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['pk'],
      username: json['username'],
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
    );
  }

  dynamic toJson() => {
        'id': userId,
        'username': username,
        'password': password,
        'token': token,
      };
}
